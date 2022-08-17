//
//  WeeklyCheckInSurver.swift
//  CardinalKit_Example
//
//  Created by Felipe Rubio on 8/08/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import ResearchKit

/// Defines the content of the weekly check-in survey.
struct WeeklyCheckInSurvey {
    /// Returns an `ORKOrderedTask` of the survey content with the information given.
    /// - Parameters:
    ///   - fallsNumber: Quantity of falls during the weel.
    ///   - fallsDescription: Description of the falls.
    /// - Returns: `ORKOrderedTask`
    static func weeklyCheckInSurvey(totalFalls:Int, fallsSummary: String) -> ORKOrderedTask  {
        var steps = [ORKStep]()
        
        // Falls resume
        let resumeStep = ORKInstructionStep(identifier: "FallsResume")
        resumeStep.title = "Last Week Falls Resume"
        resumeStep.text = "last week you reported \(totalFalls) falls \n\n\n\n\(fallsSummary)"
        
        steps += [resumeStep]
        
        // Instruction video
        let videoStep = VideoStep(identifier: "VideoInstructionsStep")
        
        steps += [videoStep]
        
        // safety form
        let safetyForm = SafetyForm(identifier: "SafetyCheck", title: "Safety Check", text: "Ensure that each of these safety conditions is met prior to your mobility assessment")
        steps += [safetyForm]
        
        // Get ready for walking
        let readyForWalkingStep = InstructionsStep(identifier: "ReadyForWalking")
        steps += [readyForWalkingStep]
        
        // Walking - done walking
        let walkingStep = WalkStep(identifier: "DoneWalking")
        steps += [walkingStep]
        
        // Final step: walking completed
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Activity Complete"
        completionStep.text = "Your data will be analyzed and you will be notified when your results are ready"
        completionStep.shouldTintImages = true
        
        steps += [completionStep]
        
        return ORKOrderedTask(identifier: "WeeklySurvey", steps: steps)
    }

}
