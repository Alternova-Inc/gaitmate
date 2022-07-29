//
//  UserDataProvider.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 1/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import CardinalKit

class UserDataProvider: UserDataProviderDelegate {
    
    public var dataBucketClinicalRecords = "gm_clinicalRecords"
    public var dataBucketHealthKit = "gm_healthKit"
    public var dataBucketStorage = "gm_storage"
    public var dataBucketMetrics = "gm_metrics"
    
    var currentUserId: String? {
        return CKStudyUser.shared.currentUser
    }
    
    public var authCollection: String? {
        if let authCollection = CKStudyUser.shared.authCollection{
            return authCollection
        }
        return nil
    }
    
    var currentUserEmail: String? {
        return CKStudyUser.shared.userEmail
    }
    
    public var scheduleCollection: String? {
        return "\(CKStudyUser.shared.rootCollection)gm_schedule"
    }
}
