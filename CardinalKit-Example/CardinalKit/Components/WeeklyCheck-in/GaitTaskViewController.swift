//
//  GaitTaskViewController.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 7/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import ResearchKit

struct GaitTaskViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ORKTaskViewController
    
    func makeCoordinator() -> SurveyViewCoordinator {
        SurveyViewCoordinator()
    }
    
    func updateUIViewController(_ uiViewController: ORKTaskViewController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> ORKTaskViewController {
        let sampleSurveyTask: ORKOrderedTask = {
            var steps = [ORKStep]()
//
//            let videoStep = VideoStep(identifier: "VideoStep")
//            steps += [videoStep]
//
//            let safe1Question = ORKFormItem(identifier: "safe_1", text: "Have you cleared a 10-foot-long space with no throw rugs or obstructions?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
//
//            let safe2Question = ORKFormItem(identifier: "safe_2", text: "Have you set up a chair on one side (ideally with arms)?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
//
//            let safe3Question = ORKFormItem(identifier: "safe_3", text: "Are you wearing regular footwear?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
//            let safe4Question = ORKFormItem(identifier: "safe_4", text: "Do you have someone present who can assist you if needed?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
//
//            let safe5Question = ORKFormItem(identifier: "safe_5", text: "Have you put on the belt with pouch to hold your phone?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
//
//            let safetyForm = ORKFormStep(identifier: "safetyCheck", title: "Safety Check", text: "Ensure that each of these safety conditions is met prior to your mobility assessment")
//            safetyForm.formItems = [safe1Question, safe2Question, safe3Question, safe4Question, safe5Question]
            
            
            let intendedUseDescription = "Tests ability to walk"
            let stepsShort = ORKOrderedTask.shortWalk(withIdentifier: "ShortWalkTask", intendedUseDescription: intendedUseDescription, numberOfStepsPerLeg: 10, restDuration: 10, options: ORKPredefinedTaskOption())
            
            
//            steps += [safetyForm]
            
            steps = stepsShort.steps
           
            
            return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
        }()
        
        let taskViewController = ORKTaskViewController(task: sampleSurveyTask, taskRun: nil)
        taskViewController.delegate = context.coordinator
        
        return taskViewController
    }
}
