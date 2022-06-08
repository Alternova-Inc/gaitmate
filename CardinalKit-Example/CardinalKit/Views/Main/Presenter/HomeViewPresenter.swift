//
//  HomeViewPresenter.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 8/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

class HomeViewPresenter:ObservableObject {
    @Published var showOnBoardingSurveyButton:Bool
    @Published var weeklySurveyButtonIsActive:Bool
    
    @Published var presentOnboardingSurvey:Bool
    @Published var presentWeeklySurvey:Bool
    
    init(){
        showOnBoardingSurveyButton = true
        presentOnboardingSurvey = false
        
        weeklySurveyButtonIsActive = false
        presentWeeklySurvey = false
        
        if let completed = UserDefaults.standard.object(forKey: Constants.onboardingSurveyDidComplete) as? Bool {
           showOnBoardingSurveyButton = !completed
        }
        else {
            NotificationCenter.default.addObserver(self, selector: #selector(OnCompleteOnboardingSurvey), name: Notification.Name(Constants.onboardingSurveyDidComplete), object: nil)
        }
        
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
        return AnyView(CKTaskViewController(tasks: OnboardingSurvey.weeklyCheckInSurvey))
    }
    
}
