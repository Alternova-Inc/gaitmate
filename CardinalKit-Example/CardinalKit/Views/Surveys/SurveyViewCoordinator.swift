//
//  SurveyViewCoordinator.swift
//  CardinalKit_Example
//
//  Created by Ankush Dhawan on 1/27/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit

class SurveyViewCoordinator: NSObject, ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        switch reason {
        case .completed:
            if taskViewController.result.identifier == "SurveyTask" {
                let date = Date()
                let weekNumber = date.weekNumber()!
                UserDefaults.standard.set(true, forKey: "WeekleySurveyOn-\(weekNumber)")
                NotificationCenter.default.post(name: NSNotification.Name(Constants.weeklySurveyComplete), object: true)
            }
            print("Complete")
        default:
            print("Discard or other")
        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, viewControllerFor step: ORKStep) -> ORKStepViewController? {
        switch step{
            case is VideoStep:
                return VideoStepViewController(step: step)
            default:
                return nil
        }
    }
    
}
