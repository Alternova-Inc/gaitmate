//
//  FinalStep.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 2/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit
import SwiftUI

public class FinalStep: ORKInstructionStep{
    public override init(identifier: String) {
        super.init(identifier: identifier)
        self.text = "UserId invalid"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

public class FinalStepViewcontroller: ORKInstructionStepViewController{
    public override func viewDidLoad() {
        
        
        if (UserDefaults.standard.string(forKey: "UserId") != nil) {
            super.goForward()
        }
        else{
            let color = Color(CKConfig.shared.readColor(query: "Primary Color"))
            view.addSubview(container)
            gradient.colors = [UIColor.white.cgColor, UIColor(color).cgColor]
            
            let signInLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 450, height: 50 ))
            signInLabel.center.x = view.center.x
            signInLabel.text = "Your participant ID is invalid please try again"
            signInLabel.textAlignment = NSTextAlignment.center
            self.view.addSubview(signInLabel)
            
            let signInButton = UIButton(frame: CGRect(x: 0, y: view.frame.maxY-400, width: view.frame.width - 100, height: 50))
            signInButton.center.x = view.center.x
            signInButton.setTitle("Try Again", for: .normal)
            signInButton.setTitleColor( UIColor(color), for: .normal)
            signInButton.backgroundColor = .white
            signInButton.layer.cornerRadius = 10
            signInButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
            self.view.addSubview(signInButton)
        }
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
    func doneAction(){
        super.goBackward()
    }
}
