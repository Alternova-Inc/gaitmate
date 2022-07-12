//
//  CKStudyUser.swift
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import Foundation
import CardinalKit
import Firebase

class CKStudyUser {
    
    static let shared = CKStudyUser()
    
    /* **************************************************************
     * the current user only resolves if we are logged in
    **************************************************************/
    var currentUser: String? {
        // this is a reference to the
        // Firebase + Google Identity User
        return UserDefaults.standard.string(forKey: "UserId")
    }
    
    /* **************************************************************
     * store your Firebase objects under this path in order to
     * be compatible with CardinalKit GCP rules.
    **************************************************************/
    var authCollection: String? {
        if let userId = currentUser,
            let root = rootAuthCollection {
            return "\(root)\(userId)/"
        }
        
        return nil
    }
    
    var surveysCollection: String? {
        if let bundleId = Bundle.main.bundleIdentifier {
            return "/studies/\(bundleId)/surveys/"
        }
        
        return nil
    }
    
    var studyCollection: String?{
        if let bundleId = Bundle.main.bundleIdentifier {
            return "/studies/\(bundleId)/"
        }
        return nil
    }
    
    fileprivate var rootAuthCollection: String? {
        if let bundleId = Bundle.main.bundleIdentifier {
            return "/studies/\(bundleId)/users/"
        }
        
        return nil
    }
    
    var isLoggedIn: Bool {
        return currentUser != nil
    }
    
   

    /**
    Save a snapshot of our current user into Firestore.
    */
    func save() {
        if let dataBucket = rootAuthCollection,
            let uid = currentUser {
            CKSession.shared.userId = uid
            let settings = FirestoreSettings()
            settings.isPersistenceEnabled = false
            let db = Firestore.firestore()
            db.settings = settings
            db.collection(dataBucket).document(uid).setData(["userID":uid, "lastActive":Date().ISOStringFromDate()])
        }
    }
}
