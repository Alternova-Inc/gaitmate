//
//  NetworkManager.swift
//  CardinalKit_Example
//
//  Created by Santiago Gutierrez on 5/17/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CardinalKit
import Firebase

class NetworkManager: CKAPIDeliveryDelegate {
    
    fileprivate func sendHealthKit(_ file: URL, _ package: Package, _ authPath: String, _ onCompletion: @escaping (Bool) -> Void) {
        
        do {
            let data = try Data(contentsOf: file)
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                onCompletion(false)
                return
            }
            
            let identifier = Date().startOfDay.shortStringFromDate() + "-\(package.fileName)"
            let trimmedIdentifier = identifier.trimmingCharacters(in: .whitespaces)
            
            let db = Firestore.firestore()
            db.collection(authPath + "\(Constants.dataBucketHealthKit)").document(trimmedIdentifier).setData(json) { err in
                
                if let err = err {
                    onCompletion(false)
                    print("Error writing document: \(err)")
                } else {
                    onCompletion(true)
                    print("Document successfully written!")
                }
            }
            
        } catch {
            print("Error \(error.localizedDescription)")
            onCompletion(false)
            return
        }
        
    }
    
    func send(file: URL, package: Package, authPath: String, onCompletion: @escaping (Bool) -> Void) {
        switch package.type {
        case .hkdata:
            sendHealthKit(file, package, authPath, onCompletion)
            break
        default:
            fatalError("Sending data of type \(package.type.description) is NOT supported.")
            break
        }
        
    }
    
}
