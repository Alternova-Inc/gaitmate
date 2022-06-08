//
//  LandingUIView.swift
//  CardinalKit_Example
//
//  Created by Laura on 06.02.22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import ResearchKit
import CardinalKit

struct HomeUIView: View {
    let color: Color
    let config = CKConfig.shared
    
    @ObservedObject var presenter = HomeViewPresenter()
   
    init(color: Color) {
        self.color = color
    }
    
    var body: some View {
        
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
                    if presenter.showOnBoardingSurveyButton {
                        HStack {
                            Spacer()
                            Button(action: {
                                presenter.presentOnboardingSurvey.toggle()
                            }, label: {
                                Image(systemName: "figure.walk")
                                Text("Onboarding survey")
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
                                .sheet(isPresented: $presenter.presentOnboardingSurvey) {
                                    presenter.onBoardingSurveyView()
                                }
                            Spacer()
                        }
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            if presenter.weeklySurveyButtonIsActive {
                                presenter.presentWeeklySurvey.toggle()
                            }
 
                        }, label: {
                            Image(systemName: "square.and.pencil")
                            Text("Weekly Check-in")
                        })
                            .padding(Metrics.PADDING_BUTTON_LABEL)
                            .foregroundColor(Color.white)
                            .font(.title)
                            .padding(.leading, Metrics.PADDING_HORIZONTAL_MAIN)
                            .padding(.trailing, Metrics.PADDING_HORIZONTAL_MAIN)
                            .frame(minWidth:300)
                            .frame(maxWidth:300)
                            .background( presenter.weeklySurveyButtonIsActive ?  self.color : Color.gray )
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .sheet(isPresented: $presenter.presentWeeklySurvey) {
                                presenter.weeklySurveyView()
                            }
                        Spacer()
                    }
                }
            )
    }
}

struct LandingUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUIView(color: Color.blue)
    }
}

