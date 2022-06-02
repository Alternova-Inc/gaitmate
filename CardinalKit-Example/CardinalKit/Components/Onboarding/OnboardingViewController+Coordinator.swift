//
//  OnboardingViewController+Coordinator.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 10/12/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import ResearchKit
import Firebase
import CardinalKit

class OnboardingViewCoordinator: NSObject, ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        let storage = Storage.storage()
        switch reason {
        case .completed:
            // if we completed the onboarding task view controller, go to study.
            // performSegue(withIdentifier: "unwindToStudy", sender: nil)
            
            // TODO: where to go next?
            // trigger "Studies UI"
            UserDefaults.standard.set(true, forKey: Constants.onboardingDidComplete)
            NotificationCenter.default.post(name: NSNotification.Name(Constants.onboardingDidComplete), object: true)
            
            if let signatureResult = taskViewController.result.stepResult(forStepIdentifier: "ConsentReviewStep")?.results?.first as? ORKConsentSignatureResult {
                
                let consentDocument = ConsentDocument()
                signatureResult.apply(to: consentDocument)

                consentDocument.makePDF { (data, error) -> Void in
                    
                    let config = CKPropertyReader(file: "CKConfiguration")
                        
                    var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last as NSURL?
                    docURL = docURL?.appendingPathComponent("\(config.read(query: "Consent File Name")).pdf") as NSURL?
                    

                    do {
                        let url = docURL! as URL
                        try data?.write(to: url)
                        
                        UserDefaults.standard.set(url.path, forKey: "consentFormURL")
                        
                        let storageRef = storage.reference()
                        
                        if let DocumentCollection = CKStudyUser.shared.authCollection {
                            let DocumentRef = storageRef.child("\(DocumentCollection)/Consent.pdf")
                            
                            // Upload the file to the path "images/rivers.jpg"
                            DocumentRef.putFile(from: url, metadata: nil) { metadata, error in
                              guard let metadata = metadata else {
                                // Uh-oh, an error occurred!
                                return
                              }
                              // Metadata contains file metadata such as size, content-type.
//                              let size = metadata.size
                              // You can also access to download URL after upload.
                                DocumentRef.downloadURL { (url, error) in
                                guard let downloadURL = url else {
                                  // Uh-oh, an error occurred!
                                  return
                                }
                              }
                            }
                        }
                        
                        
                        

                    } catch let error {

                        print(error.localizedDescription)
                    }
                }
            }
            
            
            print("Login successful! task: \(taskViewController.task?.identifier ?? "(no ID)")")
            
            fallthrough
        default:
            // otherwise dismiss onboarding without proceeding.
            taskViewController.dismiss(animated: false, completion: nil)
        }
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
//        stepViewController.goForward()
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, viewControllerFor step: ORKStep) -> ORKStepViewController? {
        
        // MARK: - Advanced Concepts
        // Overriding the view controller of an ORKStep
        // lets us run our own code on top of what
        // ResearchKit already provides!

        switch step {
        //case is NotificationStep:
            // show custom screen for allowing notifications
            // return NotificationStep(step: step)
        case is CKHealthDataStep:
            //this step lets us run custom logic to ask for
            //HealthKit permissins when this step appears on screen.
            return CKHealthDataStepViewController(step: step)
        case is CKHealthRecordsStep:
            return CKHealthRecordsStepViewController(step: step)
        case is LoginCustomWaitStep:
            // run custom code to send an email for login!
            return LoginCustomWaitStepViewController(step: step)
        case is CKSignInWithAppleStep:
            // handle Sign in with Apple
            return CKSignInWithAppleStepViewController(step: step)
        case is CKMultipleSignInStep:
            return CKMultipleSignInStepViewController(step: step)
        case is CKReviewConsentDocument:
            return CKReviewConsentDocumentViewController(step: step)
        case is CodeSignInStep:
            return CodeSignInStepViewController(step: step)
        case is FinalStep:
            return FinalStepViewcontroller(step: step)
        default:
            return nil
        }
    }
}
