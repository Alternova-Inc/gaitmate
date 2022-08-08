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
        let buttonApple = CustomButton(title: "Ready", backGroundColor: UIColor(red: 242, green: 177, blue: 55), textColor: .white, borderColor: nil, action: #selector(action), location: CGRect(x: 200, y: 200, width: 350, height: 75))
        self.view.addSubview(buttonApple)
        self.view.backgroundColor = UIColor(red: 110, green: 237, blue: 251)
    }
    
    
    public func CustomButton(
        title:String,
        backGroundColor:UIColor,
        textColor:UIColor,
        borderColor:UIColor?,
        action: Selector,
        location: CGRect
    )->UIButton{
        let button = UIButton(frame: location)
        button.center = view.center
        button.center.y = view.center.y - 200
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

