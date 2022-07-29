//
//  CKStudyUser.swift
//
//  Created for the CardinalKit Framework.
//  Copyright © 2019 Stanford University. All rights reserved.
//

import Foundation
import CardinalKit
import Firebase
import FirebaseAuth

class CKStudyUser {
    
    static let shared = CKStudyUser()
    
    /* **************************************************************
     * the current user only resolves if we are logged in
    **************************************************************/
    var currentUser: String? {
        if let user = Auth.auth().currentUser?.uid {
         return user
        }
        return nil
    }
    
    var userEmail: String? {
        if let user = Auth.auth().currentUser{
            return user.email
        }
        return nil
    }
    
    /* **************************************************************
     * store your Firebase objects under this path in order to
     * be compatible with CardinalKit GCP rules.
    **************************************************************/
    var authCollection: String? {
        if let userId = currentUser{
            return "\(rootAuthCollection)\(userId)/"
        }
        return nil
    }
    
    var surveysCollection: String? {
        if let bundleId = Bundle.main.bundleIdentifier {
            return "/studies/\(bundleId)/gm_surveys/"
        }
        
        return nil
    }
    
    var studyCollection: String?{
       return rootCollection
    }
    
    var rootCollection: String{
        return "/edu.stanford.gaitmate/gm_study/"
    }
    
    fileprivate var rootAuthCollection: String {
        return "\(rootCollection)gm_users/"
    }
    
    var isLoggedIn: Bool {
        return currentUser != nil
    }
    
   

    /**
    Save a snapshot of our current user into Firestore.
    */
    func save() {
        if let uid = currentUser {
            CKSession.shared.userId = uid
            let settings = FirestoreSettings()
            settings.isPersistenceEnabled = false
            let db = Firestore.firestore()
            db.settings = settings
            db.collection(rootAuthCollection).document(uid).setData(["userID":uid, "lastActive":Date().ISOStringFromDate()])
        }
    }
}
