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
    
    init() {
        self.color = Color(config.readColor(query: "Primary Color"))
    }
    
    var body: some View {
        TabView {
            HomeUIView(color: self.color).tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            CareTeamViewControllerRepresentable()
                .ignoresSafeArea(edges: .all)
                .tabItem {
                    Image(systemName: "cross.circle.fill")
                    Text("Contact")
            }
            
            ProfileUIView(color: self.color).tabItem {
                Image(systemName: "person.crop.circle.fill")
                Text("Profile")
            }
           
        }
        .accentColor(self.color)
        .onAppear(perform: {
            CKCareKitManager.shared.coreDataStore.createContacts()
        })
    }
}

struct MainUIView_Previews: PreviewProvider {
    static var previews: some View {
        MainUIView()
    }
}
