//
//  CKCareKitManager+Sample.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 12/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

/*
import CareKit
import CareKitStore
import Contacts
import UIKit
import FirebaseFirestore

internal extension OCKStore {

    fileprivate func insertDocuments(documents: [DocumentSnapshot]?, collection: String, authCollection: String?,lastUpdateDate: Date?,onCompletion: @escaping (Error?)->Void){
        guard let documents = documents,
             documents.count>0 else {
           onCompletion(nil)
           return
       }
        
        let group = DispatchGroup()
        for document in documents{
            group.enter()
            CKSendHelper.getFromFirestore(authCollection:authCollection, collection: collection, identifier: document.documentID) {(document, error) in
                do{
                    guard let document = document,
                          let payload = document.data(),
                          let id = payload["id"] as? String else {
                              group.leave()
                        return
                    }
                    var itemSchedule:OCKSchedule? = nil
                    var update = true
                    if lastUpdateDate != nil,
                       let updateTimeServer = payload["updateTime"] as? Timestamp,
                       updateTimeServer.dateValue()<lastUpdateDate!{
                        update = false
                    }
                    
                    if update,
                        let schedule = payload["scheduleElements"] as? [[String:Any]]
                    {
                        var scheduleElements=[OCKScheduleElement]()
                        for element in schedule{
                            var startDate = Date()
                            var endDate:Date?=nil
                            var intervalDate = DateComponents(day:2)
                            var durationElement:OCKScheduleElement.Duration = .allDay
                            if let startStamp = element["startTime"] as? Timestamp{
                                startDate = startStamp.dateValue()
                            }
                            if let endStamp = element["endTime"] as? Timestamp{
                                endDate = endStamp.dateValue()
                            }
                            
                            if let interval = element["interval"] as? [String:Any]{
                                var day = 1
                                if let dayInterval = interval["day"] as? Int{
                                    day = dayInterval
                                }
                                var seconds = 1
                                if let secondsInterval = interval["seconds"] as? Int{
                                    seconds = secondsInterval
                                }
                                intervalDate =
                                    DateComponents(
                                        timeZone: interval["timeZone"] as? TimeZone,
                                        year: interval["year"] as? Int,
                                        month: interval["month"] as? Int,
                                        day: day,
                                        hour: interval["hour"] as? Int,
                                        minute: interval["minute"] as? Int,
                                        second: seconds,
                                        weekday: interval["weekday"] as? Int,
                                        weekdayOrdinal: interval["weekdayOrdinal"] as? Int,
                                        weekOfMonth: interval["weekOfMonth"] as? Int,
                                        weekOfYear: interval["weekOfYear"] as? Int,
                                        yearForWeekOfYear: interval["yearForWeekOfYear"] as? Int)
                            }
                            if let duration = element["duration"] as? [String:Any]{
                                if let allDay = duration["allDay"] as? Bool,
                                   allDay{
                                    durationElement = .allDay
                                }
                                if let seconds = duration["seconds"] as? Double{
                                    durationElement = .seconds(seconds)
                                }
                                if let hours = duration["hours"] as? Double{
                                    durationElement = .hours(hours)
                                }
                                if let minutes = duration["minutes"] as? Double{
                                    durationElement = .minutes(minutes)
                                }
                            }
                            var targetValue:[OCKOutcomeValue] = [OCKOutcomeValue]()
                            if let targetValues = element["targetValues"] as? [[String:Any]]{
                                for target in targetValues{
                                    if let identifier = target["groupIdentifier"] as? String{
                                        var come = OCKOutcomeValue(false, units: nil)
                                            come.groupIdentifier=identifier
                                        targetValue.append(come)
                                    }
                                }
                            }
                            scheduleElements.append(OCKScheduleElement(start: startDate, end: endDate, interval: intervalDate, text: element["text"] as? String, targetValues: targetValue, duration: durationElement))
                        }
                        if scheduleElements.count>0{
                            itemSchedule = OCKSchedule(composing: scheduleElements)
                        }
                    }
                    if let itemSchedule = itemSchedule{
                        var uuid:UUID? = nil
                        if let _uuid = payload["uuid"] as? String{
                            uuid=UUID(uuidString: _uuid)
                        }
                        var task = OCKTask(id: id, title: payload["title"] as? String, carePlanUUID: uuid, schedule: itemSchedule)
                        if let impactsAdherence = payload["impactsAdherence"] as? Bool{
                            task.impactsAdherence = impactsAdherence
                        }
                        task.instructions = payload["instructions"] as? String

                        // get if task exist?
                        self.fetchTask(withID: id) { result in
                            switch result {
                                case .failure(_): do {
                                    self.addTask(task)
                                }
                            case .success(_):do {
                                self.updateTask(task)
                                }
                            }

                            group.leave()
                        }
                    }
                    else{
                        group.leave()
                    }
                    
                }
            }
        }
        group.notify(queue: .main, execute: {
            onCompletion(nil)
        })
    }
    // Adds tasks and contacts into the store
    func populateSampleData(lastUpdateDate: Date?,completion:@escaping () -> Void) {
        
        let collection: String = "carekit-store/v2/tasks"
        // Download Tasks By Study
        
        guard  let studyCollection = CKStudyUser.shared.studyCollection else {
            return
        }
        // Get tasks on study
        CKSendHelper.getFromFirestore(authCollection: studyCollection,collection: collection, onCompletion: { (documents,error) in
            self.insertDocuments(documents: documents, collection: collection, authCollection: studyCollection,lastUpdateDate:lastUpdateDate){
                (Error) in
                CKSendHelper.getFromFirestore(collection: collection, onCompletion: { (documents,error) in
                    self.insertDocuments(documents: documents, collection: collection, authCollection: nil,lastUpdateDate:lastUpdateDate){
                        (Error) in
                        self.createContacts()
                        completion()
                    }
                })
            }
        })
    }
    
    func createContacts() {
        var contact1 = OCKContact(id: "brian", givenName: "Brian",
                                  familyName: "Suffoletto", carePlanUUID: nil)
        contact1.asset = "BrianSuffoletto"
        contact1.title = "Emergency Physician"
        contact1.role = "Dr. Suffoletto is a practicing emergency physician at the Stanford Emergency Department."
        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "suffbp@stanford.edu")]
        //contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]
        //contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]

        contact1.address = {
            let address = OCKPostalAddress()
            address.street = "900 Welch Rd Ste 350"
            address.city = "Stanford"
            address.state = "CA"
            address.postalCode = "94305"
            return address
        }()

        var contact2 = OCKContact(id: "david", givenName: "David",
                                  familyName: "Kim", carePlanUUID: nil)
        contact2.asset = "DavidKim"
        contact2.title = "Emergency Physician"
        contact2.role = "Dr. David Kim is a practicing emergency physician at the Stanford Emergency Department."
        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "davidak@stanford.edu")]
        contact2.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(650) 725-9445")]
        contact2.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(650) 723-0121 (fax)")]
        contact2.address = {
            let address = OCKPostalAddress()
            address.street = "900 Welch Rd Ste 350"
            address.city = "Stanford"
            address.state = "CA"
            address.postalCode = "94305"
            return address
        }()

        addContacts([contact2, contact1])
    }
    
}

extension OCKHealthKitPassthroughStore {

    internal func populateSampleData() {

        let schedule = OCKSchedule.dailyAtTime(
            hour: 8, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(12), targetValues: [OCKOutcomeValue(2000.0, units: "Steps")])

        let steps = OCKHealthKitTask(
            id: "steps",
            title: "Daily Steps Goal 🏃🏽‍♂️",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .stepCount,
                quantityType: .cumulative,
                unit: .count()))

        addTasks([steps]) { result in
            switch result {
            case .success: print("Added tasks into HealthKitPassthroughStore!")
            case .failure(let error): print("Error: \(error)")
            }
        }
    }
}
*/


import CareKit
import CareKitStore
import Contacts
import CareKitUI
import UIKit
import FirebaseFirestore

internal extension OCKStore {
    
    // get tasks from firestore
    fileprivate func insertDocuments(documents: [DocumentSnapshot]?, collection: String, authCollection: String?,lastUpdateDate: Date?,onCompletion: @escaping (Error?)->Void){
        guard let documents = documents,
              documents.count>0 else {
                  onCompletion(nil)
                  return
              }
        
        let group = DispatchGroup()
        for document in documents{
            group.enter()
            CKSendHelper.getFromFirestore(authCollection:authCollection, collection: collection, identifier: document.documentID) {(document, error) in
                do{
                    guard let document = document,
                          let payload = document.data(),
                          let id = payload["id"] as? String else {
                              group.leave()
                              return
                          }
                    var itemSchedule:OCKSchedule? = nil
                    var update = true
                    if lastUpdateDate != nil,
                       let updateTimeServer = payload["updateTime"] as? Timestamp,
                       updateTimeServer.dateValue()<lastUpdateDate!{
                        update = false
                    }
                    
                    if update,
                       let schedule = payload["scheduleElements"] as? [[String:Any]]
                    {
                        var scheduleElements=[OCKScheduleElement]()
                        for element in schedule{
                            var startDate = Date()
                            var endDate:Date?=nil
                            var intervalDate = DateComponents(day:2)
                            var durationElement:OCKScheduleElement.Duration = .allDay
                            if let startStamp = element["startTime"] as? Timestamp{
                                startDate = startStamp.dateValue()
                            }
                            if let endStamp = element["endTime"] as? Timestamp{
                                endDate = endStamp.dateValue()
                            }
                            
                            if let interval = element["interval"] as? [String:Any]{
                                var day = 1
                                if let dayInterval = interval["day"] as? Int{
                                    day = dayInterval
                                }
                                var seconds = 1
                                if let secondsInterval = interval["seconds"] as? Int{
                                    seconds = secondsInterval
                                }
                                intervalDate =
                                DateComponents(
                                    timeZone: interval["timeZone"] as? TimeZone,
                                    year: interval["year"] as? Int,
                                    month: interval["month"] as? Int,
                                    day: day,
                                    hour: interval["hour"] as? Int,
                                    minute: interval["minute"] as? Int,
                                    second: seconds,
                                    weekday: interval["weekday"] as? Int,
                                    weekdayOrdinal: interval["weekdayOrdinal"] as? Int,
                                    weekOfMonth: interval["weekOfMonth"] as? Int,
                                    weekOfYear: interval["weekOfYear"] as? Int,
                                    yearForWeekOfYear: interval["yearForWeekOfYear"] as? Int)
                            }
                            if let duration = element["duration"] as? [String:Any]{
                                if let allDay = duration["allDay"] as? Bool,
                                   allDay{
                                    durationElement = .allDay
                                }
                                if let seconds = duration["seconds"] as? Double{
                                    durationElement = .seconds(seconds)
                                }
                                if let hours = duration["hours"] as? Double{
                                    durationElement = .hours(hours)
                                }
                                if let minutes = duration["minutes"] as? Double{
                                    durationElement = .minutes(minutes)
                                }
                            }
                            var targetValue:[OCKOutcomeValue] = [OCKOutcomeValue]()
                            if let targetValues = element["targetValues"] as? [[String:Any]]{
                                for target in targetValues{
                                    if let identifier = target["groupIdentifier"] as? String{
                                        var come = OCKOutcomeValue(false, units: nil)
//                                        come.groupIdentifier=identifier
                                        targetValue.append(come)
                                    }
                                }
                            }
                            scheduleElements.append(OCKScheduleElement(start: startDate, end: endDate, interval: intervalDate, text: element["text"] as? String, targetValues: targetValue, duration: durationElement))
                        }
                        if scheduleElements.count>0{
                            itemSchedule = OCKSchedule(composing: scheduleElements)
                        }
                    }
                    if let itemSchedule = itemSchedule{
                        var uuid:UUID? = nil
                        if let _uuid = payload["uuid"] as? String{
                            uuid=UUID(uuidString: _uuid)
                        }
                        var task = OCKTask(id: id, title: payload["title"] as? String, carePlanUUID: uuid, schedule: itemSchedule)
                        if let impactsAdherence = payload["impactsAdherence"] as? Bool{
                            task.impactsAdherence = impactsAdherence
                        }
                        task.instructions = payload["instructions"] as? String
                        
                        // get if task exist?
                        self.fetchTask(withID: id) { result in
                            switch result {
                            case .failure(_): do {
                                self.addTask(task)
                            }
                            case .success(_):do {
                                self.updateTask(task)
                            }
                            }
                            
                            group.leave()
                        }
                    }
                    else{
                        group.leave()
                    }
                    
                }
            }
        }
        group.notify(queue: .main, execute: {
            onCompletion(nil)
        })
    }
    
    // Adds tasks and contacts into the store
    func populateSampleData(lastUpdateDate: Date?,completion:@escaping () -> Void) {
        
        // Add tasks from Firestore
        let collection: String = "carekit-store/v2/tasks"
        
        guard  let studyCollection = CKStudyUser.shared.studyCollection else {
            return
        }
        
        CKSendHelper.getFromFirestore(authCollection: studyCollection,collection: collection, onCompletion: { (documents,error) in
            self.insertDocuments(documents: documents, collection: collection, authCollection: studyCollection,lastUpdateDate:lastUpdateDate){
                (Error) in
                CKSendHelper.getFromFirestore(collection: collection, onCompletion: { (documents,error) in
                    self.insertDocuments(documents: documents, collection: collection, authCollection: nil,lastUpdateDate:lastUpdateDate){
                        (Error) in
                        completion()
                    }
                })
            }
        })
        
        
        // Add ResearchKit Survey
        let thisMorning = Calendar.current.startOfDay(for: Date())
        let surveyElement = OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(month: 1))
        let surveySchedule = OCKSchedule(composing: [surveyElement])
        var survey = OCKTask(id: "onboardingSurvey", title: "Onboarding survey! 📝", carePlanUUID: nil, schedule: surveySchedule)
        survey.impactsAdherence = false
        survey.instructions = "Take this one-time survey the first time you join the app!."
        /*
        var survey = OCKTask(id: "painSurvey", title: "Take the pain survey 📝", carePlanUUID: nil, schedule: surveySchedule)
        survey.impactsAdherence = false
        survey.instructions = "Rate your pain."
         */
        
        var gaitTask = OCKTask(id: "sampleWalkingTask", title: "Sample Walking Test", carePlanUUID: nil, schedule: surveySchedule)
        gaitTask.impactsAdherence = true
        gaitTask.instructions = "Functional Mobility Assessment"
        
        var reportFall = OCKTask(id: "reportFall", title: "Report a Fall 📝", carePlanUUID: nil, schedule: surveySchedule)
        reportFall.impactsAdherence = true
        reportFall.instructions = "Take this weekly survey to report if you fell!."
        
        addTasks([gaitTask, survey, reportFall], callbackQueue: .main, completion: nil)
        
        createContacts()
    }
    
    func createContacts() {
        
        /*
        var contact1 = OCKContact(id: "about_the_study", givenName: "About",
                                  familyName: "GaitMate", carePlanUUID: nil)
        contact1.asset = "AboutGaitMate"
        contact1.title = "Remotely Identifying Temporal Risk for Falls "
        contact1.role = "GaitMate is an app to assess the risk of falls in older adults. The idea for the app was created by the two Stanford clinicians Brian Suffoletto and David Kim, who have conducted research on this topic for several years. Together with a team of students from the Stanford Byers Center for Biodesign the idea was brought to life. By using this app and participating in this study you are contributing to fall prevention. We thank you very much for your commitment and time! If you have further questions about this project feel free to reach out."
        ()
        */
        
        var contact2 = OCKContact(id: "brian", givenName: "Brian",
                                  familyName: "Suffoletto", carePlanUUID: nil)
        contact2.asset = "BrianSuffoletto"
        contact2.title = "Emergency Physician"
        contact2.role = "Dr. Brian Suffoletto is a practicing emergency physician at the Stanford Emergency Department."
        contact2.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "suffbp@stanford.edu")]
        contact2.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]
        //contact2.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]
        
        contact2.address = {
            let address = OCKPostalAddress()
            address.street = "900 Welch Rd Ste 350"
            address.city = "Stanford"
            address.state = "CA"
            address.postalCode = "94305"
            return address
        }()
        
        var contact3 = OCKContact(id: "david", givenName: "David",
                                  familyName: "Kim", carePlanUUID: nil)
        contact3.asset = "DavidKim"
        contact3.title = "Emergency Department"
        contact3.role = "Dr. David Kim is a practicing emergency physician at the Stanford Emergency Department."
        contact2.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "davidak@stanford.edu")]
        contact3.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(650) 725-9445")]
        contact3.address = {
            let address = OCKPostalAddress()
            address.street = "900 Welch Rd Ste 350"
            address.city = "Stanford"
            address.state = "CA"
            address.postalCode = "94305"
            return address
        }()
        
        addContacts([contact3, contact2])
    }
}



extension OCKHealthKitPassthroughStore {
    
    internal func populateHKSampleData() {
        
        let schedule = OCKSchedule.dailyAtTime(
            hour: 8, minutes: 0, start: Date(), end: nil, text: nil,
            duration: .hours(12), targetValues: [OCKOutcomeValue(1000.0, units: "Steps")])
        
        let steps = OCKHealthKitTask(
            id: "steps",
            title: "Daily Steps Goal 🏃🏽‍♂️",
            carePlanUUID: nil,
            schedule: schedule,
            healthKitLinkage: OCKHealthKitLinkage(
                quantityIdentifier: .stepCount,
                quantityType: .cumulative,
                unit: .count()))
        
        addTasks([steps]) { result in
            switch result {
            case .success: print("Added tasks into HealthKitPassthroughStore!")
            case .failure(let error): print("Error: \(error)")
            }
        }
    }
}
