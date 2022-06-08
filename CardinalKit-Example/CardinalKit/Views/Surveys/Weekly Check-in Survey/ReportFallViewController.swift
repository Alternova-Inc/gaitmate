//
//  ReportFallViewController.swift
//  CardinalKit_Example
//
//  Created by Ankush Dhawan on 2/12/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import ResearchKit

struct ReportFallViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = ORKTaskViewController
    
    func makeCoordinator() -> SurveyViewCoordinator {
        SurveyViewCoordinator()
    }
    
    func updateUIViewController(_ uiViewController: ORKTaskViewController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> ORKTaskViewController {
        let sampleSurveyTask: ORKOrderedTask = {
            var steps = [ORKStep]()
            
            // Calendar choice for date
            let fallDateAnswerFormat = ORKAnswerFormat.dateAnswerFormat()
            let fallDateStep = ORKQuestionStep(identifier: "fallDateStep", title: "Date of Fall", question: "What day did the fall happen?", answer: fallDateAnswerFormat)
            
            steps += [fallDateStep]
            
            let timeChoices = [
                ORKTextChoice(text: "Morning", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "Mid-day", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "Evening", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "Night Time", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "Do not recall", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
            ]
            let timeChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: timeChoices)
            let timeChoiceStep = ORKQuestionStep(identifier: "timeStep", title: "Time of Fall", question: "What time of day did the fall happen?", answer: timeChoiceAnswerFormat)
            
            steps += [timeChoiceStep]
            
            let injuryChoices = [
                ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "Yes: resulted in dressing, ice, cleaning of a wound, limb elevation, topical medication, bruise or abrasion.", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "Yes: resulted in minor medical care (e.g. suturing, application of steri-strips/skin glue, splinting or muscle/joint strain).", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                ORKTextChoice(text: "Yes: resulted in major medical care (e.g. surgery, casting, traction, required consultation for neurological or internal injury)", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
            ]
            let injuryChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: injuryChoices)
            let injuryStep = ORKQuestionStep(identifier: "injuryStep", title: "Injury Associated with Fall", question: "Did this fall result in any type of injury?", answer: injuryChoiceAnswerFormat)
            
            steps += [injuryStep]
            
            let videoStep = VideoStep(identifier: "VideoInstructionsStep")
            
            steps += [videoStep]
            
            let safe1Question = ORKFormItem(identifier: "safe_1", text: "Have you cleared a 10-foot-long space with no throw rugs or obstructions?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
            
            let safe2Question = ORKFormItem(identifier: "safe_2", text: "Have you set up a chair on one side (ideally with arms)?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))

            let safe3Question = ORKFormItem(identifier: "safe_3", text: "Are you wearing regular footwear?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))
            let safe4Question = ORKFormItem(identifier: "safe_4", text: "Do you have someone present who can assist you if needed?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))

            let safe5Question = ORKFormItem(identifier: "safe_5", text: "Have you put on the belt with pouch to hold your phone?", answerFormat: ORKBooleanAnswerFormat(yesString: "yes", noString: "no"))

            let safetyForm = ORKFormStep(identifier: "safetyCheck", title: "Safety Check", text: "Ensure that each of these safety conditions is met prior to your mobility assessment")
            safetyForm.formItems = [safe1Question, safe2Question, safe3Question, safe4Question, safe5Question]
            
            steps += [safetyForm]
            
            let instructionsWalk = InstructionsStep(identifier: "InstructionsStep")
            
            steps += [instructionsWalk]
            
            var recordConfiguration:[ORKRecorderConfiguration] = []
            recordConfiguration.append(ORKPedometerRecorderConfiguration.init(identifier: "PedometerConfig"))
            let acelerometerConfig = ORKAccelerometerRecorderConfiguration.init(identifier: "AcelerometerConfig", frequency: 100)
            recordConfiguration.append(acelerometerConfig)
            recordConfiguration.append(ORKDeviceMotionRecorderConfiguration.init(identifier: "DevicemotionConfig", frequency: 100))
            
            let walkingStep = ORKWalkingTaskStep(identifier: "WalkingStep")
            
            
            steps += [walkingStep]
            
            
            return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
        }()
        
        let taskViewController = ORKTaskViewController(task: sampleSurveyTask, taskRun: nil)
        taskViewController.delegate = context.coordinator
        
        return taskViewController
    }
}

