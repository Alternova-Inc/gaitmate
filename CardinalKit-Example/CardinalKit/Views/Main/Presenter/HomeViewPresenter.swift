//
//  HomeViewPresenter.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 8/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import CardinalKit

class HomeViewPresenter:ObservableObject {
    @Published var showOnBoardingSurveyButton:Bool
    @Published var weeklySurveyButtonIsActive:Bool
    
    @Published var presentOnboardingSurvey:Bool
    @Published var presentWeeklySurvey:Bool
    @Published var presentReportFall:Bool
    
    var fallsDict:[String:Int] = [:]
    
    var integer:Int = 1
    
    init(){
        showOnBoardingSurveyButton = true
        presentOnboardingSurvey = false
        
        weeklySurveyButtonIsActive = false
        presentWeeklySurvey = false
        
        presentReportFall = false
        
        if let completed = UserDefaults.standard.object(forKey: Constants.onboardingSurveyDidComplete) as? Bool {
           showOnBoardingSurveyButton = !completed
        }
        else {
            NotificationCenter.default.addObserver(self, selector: #selector(OnCompleteOnboardingSurvey), name: Notification.Name(Constants.onboardingSurveyDidComplete), object: nil)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(requestFalls), name: Notification.Name(Constants.fallsSurveyComplete), object: nil)
        
        let date = Date()
        // if is between noon sunday -  noon Wednesday and is not answered on this week
        let dayOfWeek = date.dayNumberOfWeek()!
        let dateHour = date.hour()!
        
        if dayOfWeek <= 4 {
            if !((dayOfWeek == 1 && dateHour < 12) || (dayOfWeek == 4 && dateHour >= 12)) {
                let weekNumber = date.weekNumber()!
                // Check if not complete
                if !(UserDefaults.standard.bool(forKey: "WeekleySurveyOn-\(weekNumber)")){
                    weeklySurveyButtonIsActive = true
                    NotificationCenter.default.addObserver(self, selector: #selector(OnCompleteWeeklySurvey), name: Notification.Name(Constants.weeklySurveyComplete), object: nil)
                }
            }
        }
        weeklySurveyButtonIsActive = true
        requestFalls()
    }
    
    @objc
    func requestFalls(){
        // Get Falls last week from firebase
        
        guard let authCollection = CKStudyUser.shared.authCollection
        else{
            return
        }
        let route = "\(authCollection)\(Constants.dataBucketSurveys)/reportAFall/falls"
        CKApp.requestData(route: route){
            response in
            self.fallsDict = [:]
            let startDate = Date().addDays(days: -7)
            if let response = response as? [String:Any]{
                for (_, data) in response {
                    if let data = data as? [String:Any],
                    let date = data["date"] as? String{
                        let dateAsDate = date.toDate("MM-dd-yyyy")
                        if dateAsDate>startDate {
                            let fallsCounter = (self.fallsDict[date] ?? 0)+1
                            self.fallsDict[date] = fallsCounter
                        }
                    }
                }
            }
        }
    }
    
    @objc
    func OnCompleteOnboardingSurvey(){
        showOnBoardingSurveyButton = false
    }
    
    @objc
    func OnCompleteWeeklySurvey(){
        weeklySurveyButtonIsActive = false
    }
    
    func onBoardingSurveyView() -> some View{
        return AnyView(CKTaskViewController(tasks: OnboardingSurvey.onboardingSurvey))
    }
    
    func weeklySurveyView() -> some View{
        requestFalls()
        var description =  ["Date", "Falls Count"].map({$0.padding(toLength: 18, withPad: " ", startingAt: 0)}).joined(separator: " | ")
        var fallsNumber = 0
        for (date, number) in fallsDict {
            description+="\n"
            description+=["\(date)","\(number)"].map({$0.padding(toLength: 15, withPad: " ", startingAt: 0)}).joined(separator: " | ")
            fallsNumber+=number
        }
        
        return AnyView(CKTaskViewController(tasks: OnboardingSurvey.weeklyCheckInSurvey(fallsNumber: fallsNumber, fallsDescription: description)))
    }
    
    func reportAFallView() -> some View{
        return AnyView(CKTaskViewController(tasks: OnboardingSurvey.reportAFallSurvey))
    }
    
}
