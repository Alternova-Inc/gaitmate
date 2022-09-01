//
//  CKTaskViewControllerDelegate.swift
//  CareKit Sample
//
//  Created by Santiago Gutierrez on 2/14/21.
//

import Foundation
import CareKit
import ResearchKit
import Firebase
import CardinalKit

class CKUploadToGCPTaskViewControllerDelegate : NSObject, ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        NotificationCenter.default.post(name: NSNotification.Name(Constants.putViewOnPortrait), object: true)
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        switch reason {
        case .completed:
            if taskViewController.result.identifier == "WeeklySurvey" {
                let date = Date()
                let weekNumber = date.weekNumber()!
                UserDefaults.standard.set(true, forKey: "WeekleySurveyOn-\(weekNumber)")
                NotificationCenter.default.post(name: NSNotification.Name(Constants.weeklySurveyComplete), object: true)
                Notifications.programNotificaitions(withOffset: true)
            }
            if taskViewController.result.identifier == "onboardingSurvey" {
                UserDefaults.standard.set(true, forKey: Constants.onboardingSurveyDidComplete)
                NotificationCenter.default.post(name: NSNotification.Name(Constants.onboardingSurveyDidComplete), object: true)
            }
            
            if taskViewController.result.identifier == "reportAFall" {
                let resultDate = ((taskViewController.result.result(forIdentifier: "fallDateStep") as? ORKStepResult)?.result(forIdentifier: "fallDateStep") as? ORKDateQuestionResult)?.dateAnswer
                let resultTimeDay = ((taskViewController.result.result(forIdentifier: "timeStep") as? ORKStepResult)?.result(forIdentifier: "timeStep") as? ORKChoiceQuestionResult)?.choiceAnswers?[0].description
                if let date = resultDate,
                let timeDay = resultTimeDay{
                    sendFallDateJson(date: date, timeDay: timeDay)
                }
                NotificationCenter.default.post(name: NSNotification.Name(Constants.fallsSurveyComplete), object: true)
            }
            
            do {
                // (1) convert the result of the ResearchKit task into a JSON dictionary
                //if let json = try CKTaskResultAsJson(taskViewController.result) {
                // Calule UrlStorage If Neccesary
                
                var urlStorage = ""
                var firestoreFileRoute = ""
                if let authCollection = CKStudyUser.shared.authCollection{
                    let identifier = Date().toString(dateFormat: "MM-dd-yyyy")
                    urlStorage = "\(authCollection)\(Constants.dataBucketSurveys)\(taskViewController.result.identifier)/\(identifier)"
                    firestoreFileRoute = "\(authCollection)gm_sensorsData/\(identifier)"
                }
                
                
                
                if let json = try CK_ORKSerialization.CKTaskAsJson(result: taskViewController.result,task: taskViewController.task!, urlStorage: urlStorage, firestoreFileRoute:firestoreFileRoute) {
                    
                    // (2) send using Firebase
                    try CKSendJSON(json)
                    
                    // (3) if we have any files, send those using Google Storage
                    if let associatedFiles = taskViewController.outputDirectory {
                        try CKSendFiles(associatedFiles, urlStorage: urlStorage, firestoreRoute: firestoreFileRoute)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            fallthrough
        default:
            taskViewController.dismiss(animated: false, completion: nil)
            
        }
    }
    
    /**
     Create an output directory for a given task.
     You may move this directory.
     
     - Returns: URL with directory location
     */
    func CKGetTaskOutputDirectory(_ taskViewController: ORKTaskViewController) -> URL? {
        do {
            let defaultFileManager = FileManager.default
            
            // Identify the documents directory.
            let documentsDirectory = try defaultFileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            // Create a directory based on the `taskRunUUID` to store output from the task.
            let outputDirectory = documentsDirectory.appendingPathComponent(taskViewController.taskRunUUID.uuidString)
            try defaultFileManager.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)
            
            return outputDirectory
        }
        catch let error as NSError {
            print("The output directory for the task with UUID: \(taskViewController.taskRunUUID.uuidString) could not be created. Error: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    /**
     Parse a result from a ResearchKit task and convert to a dictionary.
     JSON-friendly.
     
     - Parameters:
     - result: original `ORKTaskResult`
     - Returns: [String:Any] dictionary with ResearchKit `ORKTaskResult`
     */
    func CKTaskResultAsJson(_ result: ORKTaskResult) throws -> [String:Any]? {
        let jsonData = try ORKESerializer.jsonData(for: result)
        return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
    }
    
    /**
     Given a JSON dictionary, use the Firebase SDK to store it in Firestore.
     */
    func CKSendJSON(_ json: [String:Any]) throws {
        let identifier = (json["identifier"] as? String) ?? UUID().uuidString
        
        guard let authCollection = CKStudyUser.shared.authCollection,
              let userId = CKStudyUser.shared.currentUser else{
                 return
             }
        let route = "\(authCollection)\(Constants.dataBucketSurveys)/\(identifier)"
        CKApp.sendData(route: route, data: ["results": FieldValue.arrayUnion([json])], params: ["userId":"\(userId)","merge":true])
    }
    
    func sendFallDateJson(date: Date,timeDay: String) {
        let dateIdentifier = date.toString(dateFormat:"MM-dd-yyyy_HH:mm")
        let dateStr = date.toString(dateFormat:"MM-dd-yyyy")
        guard let authCollection = CKStudyUser.shared.authCollection
        else{
            return
        }
        let route = "\(authCollection)\(Constants.dataBucketSurveys)/reportAFall/falls/\(dateIdentifier)/"
        CKApp.sendData(route: route, data: ["date":dateStr,"timeDate":timeDay], params: [])
    }
    
    /**
     Given a file, use the Firebase SDK to store it in Google Storage.
     */
    func CKSendFiles(_ files: URL, urlStorage: String, firestoreRoute: String) throws {
        
        CKApp.sendDataToCloudStorage(route: urlStorage, files: files, alsoSendToFirestore: true, firestoreRoute: firestoreRoute){
            succes in
        }
//            try CKSendHelper.sendToCloudStorage(files, collection: collection, withIdentifier: identifier)
        
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, viewControllerFor step: ORKStep) -> ORKStepViewController? {
        switch step{
        case is VideoStep:
            return VideoStepViewController(step: step)
        case is InstructionsStep:
            return InstructionsStepViewController(step: step)
        case is ORKWalkingTaskStep:
            return WalkStepViewController(step: step)
        case is SafetyForm:
            return SafetyFormViewController(step: step)
        default:
            return nil
        }
    }
    
}

