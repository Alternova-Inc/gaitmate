//
//  CKCareKitManager+Sample.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 12/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CareKit
import CareKitStore
import Contacts
import UIKit
import FirebaseFirestore

internal extension OCKStore {

    fileprivate func insertDocuments(documents: [DocumentSnapshot]?, collection: String, authCollection: String?,lastUpdateDate: Date,onCompletion: @escaping (Error?)->Void){
        guard let documents = documents,
             documents.count>0 else {
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
                        onCompletion(nil)
                        return
                    }
                    var itemSchedule:OCKSchedule? = nil
                    if let schedule = payload["scheduleElements"] as? [[String:Any]],
                       let updateTime = payload["updateTime"] as? Timestamp,
                       updateTime.dateValue()>lastUpdateDate{
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
                                intervalDate =
                                    DateComponents(
                                        timeZone: interval["timeZone"] as? TimeZone,
                                        year: interval["year"] as? Int,
                                        month: interval["month"] as? Int,
                                        day: interval["day"] as? Int,
                                        hour: interval["hour"] as? Int,
                                        minute: interval["minute"] as? Int,
                                        second: interval["second"] as? Int,
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
                            scheduleElements.append(OCKScheduleElement(start: startDate, end: endDate, interval: intervalDate, text: element["text"] as? String, duration: durationElement))
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
                        self.addTask(task)
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main, execute: {
            onCompletion(nil)
        })
    }
    // Adds tasks and contacts into the store
    func populateSampleData(lastUpdateDate: Date) {
        
        /*
        let thisMorning = Calendar.current.startOfDay(for: Date())
        let aFewDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: thisMorning)!
        let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to: aFewDaysAgo)!
        let afterLunch = Calendar.current.date(byAdding: .hour, value: 14, to: aFewDaysAgo)!

        let coffeeElement = OCKScheduleElement(start: beforeBreakfast, end: nil, interval: DateComponents(day: 1))
        let coffeeSchedule = OCKSchedule(composing: [coffeeElement])
        var coffee = OCKTask(id: "coffee", title: "Drink Coffee ☕️", carePlanUUID: nil, schedule: coffeeSchedule)
        coffee.impactsAdherence = true
        coffee.instructions = "Drink coffee for good spirits!"
        
        let surveyElement = OCKScheduleElement(start: afterLunch, end: nil, interval: DateComponents(day: 1))
        let surveySchedule = OCKSchedule(composing: [surveyElement])
        var survey = OCKTask(id: "survey", title: "Take a Survey 📝", carePlanUUID: nil, schedule: surveySchedule)
        survey.impactsAdherence = true
        survey.instructions = "You can schedule any ResearchKit survey in your app."
        
        /*
         Doxylamine and Nausea DEMO.
         */
        let doxylamineSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast, end: nil,
                               interval: DateComponents(day: 2)),

            OCKScheduleElement(start: afterLunch, end: nil,
                               interval: DateComponents(day: 4))
        ])

        var doxylamine = OCKTask(id: "doxylamine", title: "Take Doxylamine",
                                 carePlanUUID: nil, schedule: doxylamineSchedule)
        doxylamine.instructions = "Take 25mg of doxylamine when you experience nausea."

        let nauseaSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: beforeBreakfast, end: nil, interval: DateComponents(day: 2),
                               text: "Anytime throughout the day", targetValues: [], duration: .allDay)
            ])

        var nausea = OCKTask(id: "nausea", title: "Track your nausea",
                             carePlanUUID: nil, schedule: nauseaSchedule)
        nausea.impactsAdherence = false
        nausea.instructions = "Tap the button below anytime you experience nausea."
        /* ---- */

        addTasks([nausea, doxylamine, survey, coffee], callbackQueue: .main, completion: nil)

        createContacts()
        
         */
        
        let collection: String = "carekit-store/v2/tasks"
        // Download Tasks By Study
        
        guard  let studyCollection = CKStudyUser.shared.studyCollection else {
            return
        }
        // Get tasks on study
        CKSendHelper.getFromFirestore(authCollection: studyCollection,collection: collection, onCompletion: { (documents,error) in
            self.insertDocuments(documents: documents, collection: collection, authCollection: studyCollection,lastUpdateDate:lastUpdateDate){
                (Error) in
                if let Error = Error{
                    print("error \(Error)")
                }
                else{
                    // get task on user
                    CKSendHelper.getFromFirestore(collection: collection, onCompletion: { (documents,error) in
                        self.insertDocuments(documents: documents, collection: collection, authCollection: nil,lastUpdateDate:lastUpdateDate){
                            (Error) in
                            if let Error = Error{
                                print("error \(Error)")
                            }
                            else{
                                self.createContacts()
                            }
                        }
                    })
                }
            }
        })
    }
    
    func createContacts() {
        var contact1 = OCKContact(id: "oliver", givenName: "Oliver",
                                  familyName: "Aalami", carePlanUUID: nil)
        contact1.asset = "OliverAalami"
        contact1.title = "Vascular Surgeon"
        contact1.role = "Dr. Aalami is the director of the CardinalKit project."
        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "aalami@stanford.edu")]
        contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]
        contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]

        contact1.address = {
            let address = OCKPostalAddress()
            address.street = "318 Campus Drive"
            address.city = "Stanford"
            address.state = "CA"
            address.postalCode = "94305"
            return address
        }()

        var contact2 = OCKContact(id: "johnny", givenName: "Johnny",
                                  familyName: "Appleseed", carePlanUUID: nil)
        contact2.asset = "JohnnyAppleseed"
        contact2.title = "OBGYN"
        contact2.role = "Dr. Appleseed is an OBGYN with 13 years of experience."
        contact2.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(324) 555-7415")]
        contact2.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(324) 555-7415")]
        contact2.address = {
            let address = OCKPostalAddress()
            address.street = "318 Campus Drive"
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
