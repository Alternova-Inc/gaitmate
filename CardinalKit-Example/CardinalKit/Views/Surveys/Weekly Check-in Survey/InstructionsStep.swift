//
//  InstructionsStep.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 8/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit
import UIKit

public class InstructionsStep: ORKInstructionStep{
    public override init(identifier: String) {
        super.init(identifier: identifier)
        self.title = ""
        self.text = ""
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class InstructionsStepViewController: ORKInstructionStepViewController{
    override public func viewDidLoad() {
        
        
        self.view.addSubview(beforeReadyLabel())
        self.view.addSubview(afterReadyText())
        
        let buttonReady = CustomButton(title: "Ready", backGroundColor: UIColor(red: 242, green: 177, blue: 55), textColor: .white, borderColor: nil, action: #selector(action), location: CGRect(x: 0, y: 550, width: 350, height: 75))
        
        self.view.addSubview(buttonReady)
        
        self.view.backgroundColor = UIColor(red: 110, green: 237, blue: 251)
    }
    
    private func beforeReadyLabel() -> UILabel{
        let boldAttribute = [
          NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 18.0)!
        ]
        
        let boldText = NSAttributedString(string: "Before", attributes: boldAttribute)
        let regularText = NSAttributedString(string: " you press the Ready button: \n", attributes: regularAttribute)
        let finalText = NSMutableAttributedString()
        finalText.append(boldText)
        finalText.append(regularText)
                
        var numericList = [String]()
        numericList.append("1. Put on the fanny pack with the pocket in the front")
        numericList.append("2. Stand in front of a chair")
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        attributes[.foregroundColor] = UIColor.darkGray
        
        let paragraphStyle = NSMutableParagraphStyle()
        attributes[.paragraphStyle] = paragraphStyle

        let numericListText = numericList.joined(separator: "\n")
        let regularString = NSAttributedString(string: numericListText, attributes: attributes)
        finalText.append(regularString)
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width - 50, height: 150 ))
        label.center.x = view.center.x
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 6
        label.attributedText = finalText
        
        return label
    }
    
    private func afterReadyText() -> UILabel{
        let boldAttribute = [
          NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 18.0)!
        ]
        
        let boldText = NSAttributedString(string: "After", attributes: boldAttribute)
        let regularText = NSAttributedString(string: " you press the Ready button: \n", attributes: regularAttribute)
        let finalText = NSMutableAttributedString()
        finalText.append(boldText)
        finalText.append(regularText)
                
        var numericList = [String]()
        numericList.append("1. Put the phone in the pocket of the fanny pack")
        numericList.append("2. Turn it to rest on your lower back")
        numericList.append("3. Sit down in the chair")
        numericList.append("4. Immediately stand and complete the walking task")
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.preferredFont(forTextStyle: .body)
        attributes[.foregroundColor] = UIColor.darkGray
        
        let paragraphStyle = NSMutableParagraphStyle()
        attributes[.paragraphStyle] = paragraphStyle

        let numericListText = numericList.joined(separator: "\n")
        let regularString = NSAttributedString(string: numericListText, attributes: attributes)
        finalText.append(regularString)
        
        let label = UILabel(frame: CGRect(x: 0, y: 300, width: view.frame.width - 50, height: 150 ))
        label.center.x = view.center.x
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 6
        label.attributedText = finalText
        
        
        return label
    }
    
    private func CustomButton(
        title:String,
        backGroundColor:UIColor,
        textColor:UIColor,
        borderColor:UIColor?,
        action: Selector,
        location: CGRect
    )->UIButton{
        
        let button = UIButton(frame: location)
//        button.center = view.center
//        button.center.y = view.center.y - 200
        button.center.x = view.center.x
        button.setTitle(title, for: .normal)
        
        button.setTitleColor(textColor,for: .normal)
        button.addTarget(self,action: action,for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = backGroundColor
        if let borderColor=borderColor{
            button.layer.borderWidth = 2
            button.layer.borderColor =  borderColor.cgColor
        }
        return button
    }
    
    @objc
    func action(){
        super.goForward()
    }
}

extension String {
func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
  let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
  let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
  let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
  let range = (self as NSString).range(of: text)
  fullString.addAttributes(boldFontAttribute, range: range)
  return fullString
}}


