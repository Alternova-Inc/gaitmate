//
//  CKCareKitManager+Sample.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 12/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CareKit
import CareKitStore
import Contacts
import CareKitUI
import UIKit
import FirebaseFirestore

internal extension OCKStore {
    
    func createContacts() {
        
        var contact2 = OCKContact(id: "brian", givenName: "Brian",
                                  familyName: "Suffoletto", carePlanUUID: nil)
        contact2.asset = "BrianSuffoletto"
        contact2.title = "Emergency Physician"
        contact2.role = "Dr. Brian Suffoletto is a practicing emergency physician at the Stanford Emergency Department."
        contact2.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "suffbp@stanford.edu")]
//        contact2.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]
        //contact2.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "(111) 111-1111")]
        
        contact2.address = {
            let address = OCKPostalAddress()
            address.street = "900 Welch Rd Ste 350"
            address.city = "Stanford"
            address.state = "CA"
            address.postalCode = "94305"
            return address
        }()
        
        var contact3 = OCKContact(id: "david", givenName: "David",
                                  familyName: "Kim", carePlanUUID: nil)
        contact3.asset = "DavidKim"
        contact3.title = "Emergency Department"
        contact3.role = "Dr. David Kim is a practicing emergency physician at the Stanford Emergency Department."
        contact3.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "davidak@stanford.edu")]
        
        contact3.address = {
            let address = OCKPostalAddress()
            address.street = "900 Welch Rd Ste 350"
            address.city = "Stanford"
            address.state = "CA"
            address.postalCode = "94305"
            return address
        }()
        
        addContacts([contact3, contact2])
    }
}
