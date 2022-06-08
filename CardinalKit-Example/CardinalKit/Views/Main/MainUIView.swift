//
//  MainUIView.swift
//  CardinalKit_Example
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import SwiftUI

struct MainUIView: View {
    
    let color: Color
    let config = CKConfig.shared
    @State var completeOnboardingSurvey = false
    
    @State var useCareKit = false
    @State var carekitLoaded = false
    
    init() {
        self.color = Color(config.readColor(query: "Primary Color"))
    }
    
    var body: some View {
        TabView {
            if completeOnboardingSurvey{
                HomeUIView(color: self.color).tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
                if useCareKit && carekitLoaded {
                    ScheduleViewControllerRepresentable()
                        .ignoresSafeArea(edges: .all)
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Schedule")
                    }
                    
                    CareTeamViewControllerRepresentable()
                        .ignoresSafeArea(edges: .all)
                        .tabItem {
                            Image(systemName: "cross.circle.fill")
                            Text("Contact")
                    }
                }
                
                ProfileUIView(color: self.color).tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
            }
            else{
                OnBoardingSurveyview(color: self.color)
            }
           
        }
        .accentColor(self.color)
        .onAppear(perform: {
            self.useCareKit = config.readBool(query: "Use CareKit")
            
            let lastUpdateDate:Date? = UserDefaults.standard.object(forKey: Constants.prefCareKitCoreDataInitDate) as? Date
            CKCareKitManager.shared.coreDataStore.populateSampleData(lastUpdateDate:lastUpdateDate){() in
                self.carekitLoaded = true
            }
            
            if let completed = UserDefaults.standard.object(forKey: "CompleteOnBoardingTask") as? Bool {
               self.completeOnboardingSurvey = completed
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("CompleteOnBoardingTask"))){
            notification in
            self.completeOnboardingSurvey = true
        }
    }
}

struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
