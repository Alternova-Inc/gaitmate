//
//  HomeViewPresenter.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 8/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

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
        
        if let completed = UserDefaults.standard.object(forKey: "CompleteOnBoardingTask") as? Bool {
           showOnBoardingSurveyButton = !completed
        }
        else {
            NotificationCenter.default.addObserver(self, selector: #selector(OnCompleteOnboardingSurvey), name: Notification.Name("CompleteOnBoardingTask"), object: nil)
        }
    }
    
    @objc
    func OnCompleteOnboardingSurvey(){
        showOnBoardingSurveyButton = false
        UserDefaults.standard.set(true, forKey: "CompleteOnBoardingTask")
    }
}
