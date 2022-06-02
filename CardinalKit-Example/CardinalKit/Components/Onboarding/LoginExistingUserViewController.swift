//
//  LoginViewController.swift
//  CardinalKit_Example
//
//  Created by Varun Shenoy on 3/2/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import UIKit
import ResearchKit
import CardinalKit
import Firebase

struct LoginExistingUserViewController: UIViewControllerRepresentable {
    
    func makeCoordinator() -> OnboardingViewCoordinator {
        OnboardingViewCoordinator()
    }

    typealias UIViewControllerType = ORKTaskViewController
    
    func updateUIViewController(_ taskViewController: ORKTaskViewController, context: Context) {}
    func makeUIViewController(context: Context) -> ORKTaskViewController {
        let config = CKPropertyReader(file: "CKConfiguration")
        
        var loginSteps: [ORKStep]
        let codeSignInStep = CodeSignInStep(identifier: "SignInStep")
//        CKMultipleSignInStep(identifier: "SignInButtons")
//        let loginUserPassword = ORKLoginStep(identifier: "LoginExistingStep", title: "Login", text: "Log into this study.", loginViewControllerClass: LoginViewController.self)
        loginSteps = [codeSignInStep]
//                      loginUserPassword
        
        // schedule notifications
        //let notificationStep = NotificationStep(identifier: "Notifications")
        
        // set health data permissions
//        let healthDataStep = CKHealthDataStep(identifier: "HealthKit")
//        let healthRecordsStep = CKHealthRecordsStep(identifier: "HealthRecords")
        
        //add consent if user dont have consent in cloud
        
        let consentDocument = ConsentDocument()
        /* **************************************************************
        **************************************************************/
        // use the `ORKConsentReviewStep` from ResearchKit
        let signature = consentDocument.signatures?.first
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
        reviewConsentStep.text = config.read(query: "Review Consent Step Text")
        reviewConsentStep.reasonForConsent = config.read(query: "Reason for Consent Text")
        
        
        let consentReview = CKReviewConsentDocument(identifier: "ConsentReview")
        
        
//        // set passcode
//        let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
//        let type = config.read(query: "Passcode Type")
//        if type == "6" {
//            passcodeStep.passcodeType = .type6Digit
//        } else {
//            passcodeStep.passcodeType = .type4Digit
//        }
//        passcodeStep.text = config.read(query: "Passcode Text")
        
        let finalStep = FinalStep(identifier: "FinalStep")
        // create a task with each step
        loginSteps += [consentReview, reviewConsentStep, finalStep]
        // healthRecordsStep
        // notificationStep
        // healthDataStep
        // passcodeStep
        
        
        
        let navigableTask = ORKNavigableOrderedTask(identifier: "StudyLoginTask", steps: loginSteps)
//        let orderedTask = ORKOrderedTask(identifier: "StudyLoginTask", steps: loginSteps)
        
        let resultSelector = ORKResultSelector(resultIdentifier: "SignInStep")
        let booleanAnswerType = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
        let predicateRule = ORKPredicateStepNavigationRule(resultPredicates: [booleanAnswerType],
                                                           destinationStepIdentifiers: ["ConsentReview"],
                                                           defaultStepIdentifier: "FinalStep",
                                                           validateArrays: true)
        navigableTask.setNavigationRule(predicateRule, forTriggerStepIdentifier: "SignInStep")
        
        // ADD New navigation Rule (if has or not consentDocument)
        // Consent Rule
        let resultConsent = ORKResultSelector(resultIdentifier: "ConsentReview")
        let booleanAnswerConsent = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultConsent, expectedAnswer: true)
        let predicateRuleConsent = ORKPredicateStepNavigationRule(resultPredicates: [booleanAnswerConsent],
                                                           destinationStepIdentifiers: ["FinalStep"],
                                                           defaultStepIdentifier: "ConsentReviewStep",
                                                           validateArrays: true)
        navigableTask.setNavigationRule(predicateRuleConsent, forTriggerStepIdentifier: "ConsentReview")
        
        
        
        
        // wrap that task on a view controller
        let taskViewController = ORKTaskViewController(task: navigableTask, taskRun: nil)
        taskViewController.delegate = context.coordinator // enables `ORKTaskViewControllerDelegate` below
        
        // & present the VC!
        return taskViewController
    }
    
}

