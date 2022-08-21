//
//  OnboardingUIView.swift
//  CardinalKit_Example
//
//  Created by Varun Shenoy on 8/14/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import SwiftUI
import UIKit
import ResearchKit
import CardinalKit
import Firebase

/// A view that determines and displays which view should be at launch time.
/// Also, it is the first view that is called for in `SceneDelegate`
struct LaunchUIView: View {
    
    @State var didCompleteOnboarding = false
    
    init() {
        
    }

    var body: some View {
        VStack(spacing: 10) {
            // Displays the corresponding view if the user has completed or not the onboarding survey.
            if didCompleteOnboarding && (CKStudyUser.shared.currentUser != nil){
                MainUIView()
            } else {
                OnboardingUIView() {
                    //on complete
                    if let completed = UserDefaults.standard.object(forKey: Constants.onboardingDidComplete) as? Bool {
                       self.didCompleteOnboarding = completed
                    }
                }
            } // Action to perform before the `VStack` appears
        }.onAppear(perform: {
            if let completed = UserDefaults.standard.object(forKey: Constants.onboardingDidComplete) as? Bool {
               self.didCompleteOnboarding = completed
            }
        }).onReceive(NotificationCenter.default.publisher(for: NSNotification.Name(Constants.onboardingDidComplete))) { notification in
            if let newValue = notification.object as? Bool {
                self.didCompleteOnboarding = newValue
            } else if let completed = UserDefaults.standard.object(forKey: Constants.onboardingDidComplete) as? Bool {
               self.didCompleteOnboarding = completed
            }
        }
        
    }
}

struct LaunchUIView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchUIView()
            .previewDevice("iPhone 12 Pro")
    }
}
