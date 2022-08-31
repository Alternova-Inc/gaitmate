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

/// A Class that is responsible for all the logic needed in `HomeUIView`.
/// Controlls when `HomeUIView` should show its buttons and present
/// their respective sheet.
class HomeViewPresenter: ObservableObject {
    @Published var showOnBoardingSurveyButton: Bool
    @Published var weeklySurveyButtonIsActive: Bool
    
    @Published var presentOnboardingSurvey: Bool
    @Published var presentWeeklySurvey: Bool
    @Published var presentReportFall: Bool
    
    /// Creates an instance that initializes the properties needed in `HomeUIView`.
    init() {
        showOnBoardingSurveyButton = true
        presentOnboardingSurvey = false
        
        weeklySurveyButtonIsActive = false
        presentWeeklySurvey = false
        
        presentReportFall = false
        /* ******************************************************************
         * if there is a key for Constants.onboardingSurveyDidComplete is because the
         * survey was previously completed and its value will always be true, so if it
         * goes inside of the if let statement we are going to set its opposite value
         * to showOnBoardingSurveyButton so when HomeUIView is called the button will not show.
         *
         * if there is no key, we will add an observer that in the case of the notification
         * is triggered will invoke OnCompleteOnboardingSurvey method and will set the
         * showOnBoardingSurverButton variable to false and the HomeUIView will update its view.
         *******************************************************************/
        if let completed = UserDefaults.standard.object(forKey: Constants.onboardingSurveyDidComplete) as? Bool {
           showOnBoardingSurveyButton = !completed
        }
        else {
            NotificationCenter.default.addObserver(self, selector: #selector(OnCompleteOnboardingSurvey), name: Notification.Name(Constants.onboardingSurveyDidComplete), object: nil)
        }
        // ******************************************************************
        
        // if date is between noon sunday - noon Wednesday and is not answered on this week
        let date = Date()
        let dayOfWeek = date.dayNumberOfWeek()!
        let dateHour = date.hour()!
        
        if dayOfWeek <= 4 && !((dayOfWeek == 1 && dateHour < 12) || (dayOfWeek == 4 && dateHour >= 12)) {
            let weekNumber = date.weekNumber()!
            // Check if not complete
            if !(UserDefaults.standard.bool(forKey: "WeekleySurveyOn-\(weekNumber)")){
                weeklySurveyButtonIsActive = true
                NotificationCenter.default.addObserver(self, selector: #selector(OnCompleteWeeklySurvey), name: Notification.Name(Constants.weeklySurveyComplete), object: nil)
            }
        }
        weeklySurveyButtonIsActive = true
    }
    
    @objc
    func OnCompleteOnboardingSurvey(){
        showOnBoardingSurveyButton = false
    }
    
    @objc
    func OnCompleteWeeklySurvey(){
        weeklySurveyButtonIsActive = false
    }
    
    /// Returns a view of the onboarding survey content.
    func onBoardingSurveyView() -> some View{
        return AnyView(CKTaskViewController(tasks: OnboardingSurvey.onboardingSurvey))
    }
    
    /// Returns a view of the weekly survey content.
    func weeklySurveyView() -> some View{
        return AnyView(CKTaskViewController(tasks: WeeklyCheckInSurvey.weeklyCheckInSurvey()))
    }
    
    /// Returns a view of the report a fall survey.
    func reportAFallView() -> some View{
        return AnyView(CKTaskViewController(tasks: ReportAFallSurvey.reportAFallSurvey))
    }
    
}
