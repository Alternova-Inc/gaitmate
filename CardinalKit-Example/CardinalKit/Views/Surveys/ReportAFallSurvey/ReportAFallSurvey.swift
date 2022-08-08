//
//  ReportAFallSurvey.swift
//  CardinalKit_Example
//
//  Created by Felipe Rubio on 8/08/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import ResearchKit

/// Defines the content of the report a fall rurvey.
struct ReportAFallSurvey {
    ///  Returns an ORKOrderedTask of the survey content.
    static let reportAFallSurvey: ORKOrderedTask = {
        // Calendar choice for date
        var steps = [ORKStep]()
        let fallDateAnswerFormat = ORKAnswerFormat.dateAnswerFormat()
        let fallDateStep = ORKQuestionStep(identifier: "fallDateStep", title: "Date of Fall", question: "What day did the fall happen?", answer: fallDateAnswerFormat)
        fallDateStep.isOptional = false
        
        steps += [fallDateStep]
        
        // At what time form
        let timeChoices = [
            ORKTextChoice(text: "Morning", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Mid-day", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Evening", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Night", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Do not recall", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let timeChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: timeChoices)
        let timeChoiceStep = ORKQuestionStep(identifier: "timeStep", title: "Time of Fall", question: "What time of day did the fall happen?", answer: timeChoiceAnswerFormat)
        timeChoiceStep.isOptional = false
        
        steps += [timeChoiceStep]
        
        // Type of injuries form
        let injuryChoices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: resulted in dressing, ice, cleaning of a wound, limb elevation, topical medication, bruise or abrasion.", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: resulted in minor medical care (e.g. suturing, application of steri-strips/skin glue, splinting or muscle/joint strain).", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes: resulted in major medical care (e.g. surgery, casting, traction, required consultation for neurological or internal injury)", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let injuryChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: injuryChoices)
        let injuryStep = ORKQuestionStep(identifier: "injuryStep", title: "Injury Associated with Fall", question: "Did this fall result in any type of injury?", answer: injuryChoiceAnswerFormat)
        injuryStep.isOptional = false
        
        steps += [injuryStep]
        let ordered = ORKOrderedTask(identifier: "reportAFall", steps: steps)
        return ordered
    }()
}
