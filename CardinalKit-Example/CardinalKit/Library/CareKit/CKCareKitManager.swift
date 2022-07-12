//
//  CKCareKitManager.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 12/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CareKit
import CareKitStore

class CKCareKitManager: NSObject {
    
    let coreDataStore = OCKStore(name: "CKCareKitStore", type: .onDisk(protection: .complete), remote: nil)
    let healthKitStore:OCKHealthKitPassthroughStore
//    let healthKitStore = OCKHealthKitPassthroughStore(name: "CKCareKitHealthKitStore", type: .onDisk)
    private(set) var synchronizedStoreManager: OCKSynchronizedStoreManager!
    
    static let shared = CKCareKitManager()
    
    override init() {
        healthKitStore = OCKHealthKitPassthroughStore(store: coreDataStore)
        super.init()
        let coordinator = OCKStoreCoordinator()
        coordinator.attach(eventStore: healthKitStore)
        coordinator.attach(store: coreDataStore)
        synchronizedStoreManager = OCKSynchronizedStoreManager(wrapping: coordinator)
    }
    
}
