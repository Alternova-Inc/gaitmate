//
//  SafetyForm.swift
//  CardinalKit_Example
//
//  Created by Julian Esteban Ramos Martinez on 28/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit

class SafetyForm:ORKFormStep{
    override init(identifier: String, title: String?, text: String?) {
        super.init(identifier: identifier, title: title, text: text)
        
        let safe1Question = ORKFormItem(identifier: "safe_1", text: "Have you cleared a 10-foot-long space with no throw rugs or obstructions?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
        safe1Question.isOptional = false
        
        let safe2Question = ORKFormItem(identifier: "safe_2", text: "Have you set up a chair on one side (ideally with arms)?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
        safe2Question.isOptional = false

        let safe3Question = ORKFormItem(identifier: "safe_3", text: "Are you wearing regular footwear?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
        safe3Question.isOptional = false
        
        let safe4Question = ORKFormItem(identifier: "safe_4", text: "Do you have someone present who can assist you if needed?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
        safe4Question.isOptional = false

        let safe5Question = ORKFormItem(identifier: "safe_5", text: "Have you put on the belt with pouch to hold your phone?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
        safe5Question.isOptional = false
        
        self.formItems = [safe1Question, safe2Question, safe3Question, safe4Question, safe5Question]
        
        self.isOptional = false
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SafetyFormViewController: ORKFormStepViewController{
//    var errorLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 100, width: 450, height: 50 ))
    
    public var formStep: SafetyForm!{
        return step as? SafetyForm
    }
    
    override func goForward() {
        var pass = true
        for  result in self.result!.results!{
            if let result = result as? ORKBooleanQuestionResult{
                if (result.booleanAnswer == 0) {
                    pass = false
                }
            }
        }
        if pass{
            super.goForward()
        }
        else {
            let alert = UIAlertController(title: "You answered one or more safety questions incorrectly.", message: "Please complete the gait task only when you have met the above requirements.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
