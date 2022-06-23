//
//  Notifications.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 23/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

public class Notifications {
    
    public static func programNotificaitions(withOffset:Bool = false){
        // Request permission to send user notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                // Remove previous notifications programed
                
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                
               //------------------Report Fall Notification--------------------//
                let content = UNMutableNotificationContent()
                content.title = "Gait Task"
                content.subtitle = "Time for your monthly mobility assessment"
                content.sound = UNNotificationSound.default

                // Configure the recurring date
                var dateComponents1 = DateComponents()
                dateComponents1.calendar = Calendar.current
                dateComponents1.weekday = 1  // Sunday
                dateComponents1.hour = 12    // 12 m
                dateComponents1.minute = 00
                let trigger1 = UNCalendarNotificationTrigger(
                         dateMatching: dateComponents1, repeats: true)
                
                // show this notification five seconds from now
                //let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                // choose a random identifier
                let request1 = UNNotificationRequest(identifier: "Gait_Task_1", content: content, trigger: trigger1)
                var dateComponents2 = DateComponents()
                
                if(withOffset){
                    var datecomponent = DateComponents()
                    datecomponent.day = 1
                    let fromDate = Calendar.current.date(byAdding: datecomponent, to: Date())
                    // Configure the recurring date from tomorrow
                    dateComponents2 = Calendar.current.dateComponents([], from: fromDate!)
                }
                else{
                    // Else from today
                    dateComponents2.calendar = Calendar.current
                }
                dateComponents2.weekday = 1   // Sunday
                dateComponents2.hour = 20    // 8:00 pm
                dateComponents2.minute = 00
                
                let trigger2 = UNCalendarNotificationTrigger(
                         dateMatching: dateComponents2, repeats: true)
                print(trigger2.nextTriggerDate() ?? "nil")
                
                // choose a random identifier
                let request2 = UNNotificationRequest(identifier: "Gait_Task_2", content: content, trigger: trigger2)

                // add both notification requests to notification center
                UNUserNotificationCenter.current().add(request1)
                UNUserNotificationCenter.current().add(request2)
                
                
                
            }
        }
    }
}
