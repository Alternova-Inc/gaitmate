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
    var currentUserId: String? {
        return CKStudyUser.shared.currentUser
    }
    
    public var authCollection: String? {
        if let userId = CKStudyUser.shared.currentUser,
            let root = rootAuthCollection {
            return "\(root)\(userId)/"
        }
        
        return nil
    }
    
    fileprivate var rootAuthCollection: String? {
        if let bundleId = Bundle.main.bundleIdentifier {
            return "/studies/\(bundleId)/users/"
        }
        return nil
    }
    
    var currentUserEmail: String? {
        return ""
    }
}
