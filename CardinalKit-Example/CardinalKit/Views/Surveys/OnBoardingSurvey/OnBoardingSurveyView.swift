//
//  OnBoardingSurveyView.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 2/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import ResearchKit

struct OnBoardingSurveyview: View{
    let color: Color
    
    @State var showingGaitTask = false
    
    init(color: Color) {
        self.color = color
    }
    
    var body: some View{
        let gradient = Gradient(colors: [.white, color.self] )
        
        LinearGradient(gradient: gradient, startPoint: .bottomTrailing, endPoint: .topLeading)
            .edgesIgnoringSafeArea(.vertical)
            .overlay (
                
        VStack (alignment: .leading, spacing: 30) {
            
            Image("GaitMate-02-white")
                .resizable()
                .scaledToFit()
                .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN*7)
                .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN*7)
            
            Spacer()
                .frame(height: 10)
        
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    self.showingGaitTask.toggle()
 
                }, label: {
                    Image(systemName: "figure.walk")
                    Text("Onboarding Task")
                })
                    .padding(Metrics.PADDING_BUTTON_LABEL)
                    .foregroundColor(Color.white)
                    .font(.title)
                    .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN)
                    .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN)
                    .frame(minWidth:300)
                    .frame(maxWidth:300)
                    .background(self.color)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .sheet(isPresented: $showingGaitTask) {
                        return AnyView(CKTaskViewController(tasks: OnboardingSurvey.onboardingSurvey))
                    }
                
                Spacer()
            }
        }
        )
    }
}

struct OnBoardingSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingSurveyview(color: Color.blue)
    }
}
