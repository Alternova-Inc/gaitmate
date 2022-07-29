//
//  AppDelegate+CardinalKit.swift
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import Foundation
import ResearchKit
import Firebase
import CardinalKit

// Extensions add new functionality to an existing class, structure, enumeration, or protocol type.
// https://docs.swift.org/swift-book/LanguageGuide/Extensions.html
extension AppDelegate {
    
    /**
     Handle special CardinalKit logic for when the app is launched.
    */
    func CKAppLaunch() {
        
        // (1) lock the app and prompt for passcode before continuing
        // CKLockApp()
        var ckOptions = CKAppOptions()
        ckOptions.userDataProviderDelegate = UserDataProvider()
        // (2) setup the CardinalKit SDK
        CKApp.configure(ckOptions)
        
        var hkTypesToReadInBackground: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!,
            HKObjectType.quantityType(forIdentifier: .walkingStepLength)!,
            HKObjectType.quantityType(forIdentifier: .walkingAsymmetryPercentage)!,
            HKObjectType.quantityType(forIdentifier: .walkingDoubleSupportPercentage)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .stairAscentSpeed)!,
            HKObjectType.quantityType(forIdentifier: .stairDescentSpeed)!,
            HKObjectType.quantityType(forIdentifier: .sixMinuteWalkTestDistance)!
        ]
        if #available(iOS 15.0, *) {
            hkTypesToReadInBackground.insert(HKObjectType.quantityType(forIdentifier: .appleWalkingSteadiness)!)
        }
        
        CKApp.configureHealthKitTypes(types: hkTypesToReadInBackground, clinicalTypes: [])
        
        // (3) if we have already logged in
        if CKStudyUser.shared.isLoggedIn {
            CKStudyUser.shared.save()
            CKApp.startBackgroundDeliveryData()
        }
        CKStudyUser.shared.save()
        
        
    }
    
}
