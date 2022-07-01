//
//  CodeSignInStep.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 1/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit
import SwiftUI

public class CodeSignInStep: ORKQuestionStep{
    public override init(identifier:String){
        super.init(identifier: identifier)
        self.answerFormat = ORKAnswerFormat.booleanAnswerFormat()
    }
    
    @available(*, unavailable)
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CodeSignInStepViewController: ORKQuestionStepViewController {
    
    var uiTextField: UITextField = UITextField()
    
    public var CodeSignInStep: CodeSignInStep!{
        return step as? CodeSignInStep
    }
    
    public override func viewDidLoad() {
       
        let color = Color(CKConfig.shared.readColor(query: "Primary Color"))
        view.addSubview(container)
        gradient.colors = [UIColor.white.cgColor, UIColor(color).cgColor]
        
        let signInLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 450, height: 50 ))
        signInLabel.center.x = view.center.x
        signInLabel.text = "Enter your ParticipantID"
        signInLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(signInLabel)
        
        uiTextField = UITextField(frame: CGRect(x: 0, y: 200, width: view.frame.width - 50, height: 50))
        uiTextField.center.x = view.center.x
        uiTextField.placeholder = "ParticipantID"
        uiTextField.backgroundColor = UIColor.white
        uiTextField.resignFirstResponder()
        self.view.addSubview(uiTextField)
        
        self.addDoneButtonOnKeyboard()
        
        let signInButton = UIButton(frame: CGRect(x: 0, y: view.frame.maxY-400, width: view.frame.width - 100, height: 50))
        signInButton.center.x = view.center.x
        signInButton.setTitle("SignIn", for: .normal)
        signInButton.setTitleColor( UIColor(color), for: .normal)
        signInButton.backgroundColor = .white
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        self.view.addSubview(signInButton)
        
        
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        uiTextField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        uiTextField.resignFirstResponder()
    }
    
    let gradient = CAGradientLayer()

    lazy var container : UIView = {
        var newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        newView.layer.insertSublayer(gradient, at: 0)
        return newView
    }()
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = container.bounds
    }
    
    @objc
    func signInAction(){
        let nText:String = uiTextField.text!.removeSpecialCharsFromString()
        
        let url = URL(string: "https://us-central1-cardinalkit-testing.cloudfunctions.net/userIdVerification?userId=\(nText)")
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                let response = String(data: data, encoding: .utf8)!
                OperationQueue.main.addOperation {
                    if response == "true"{
                        UserDefaults.standard.set(nText, forKey: "UserId")
                        self.setAnswer(true)
                    }
                    else{
                        self.setAnswer(false)
                    }
                    super.goForward()
                }
            }
            task.resume()
        }
        else{
            self.setAnswer(false)
            super.goForward()
        }
    }
}

