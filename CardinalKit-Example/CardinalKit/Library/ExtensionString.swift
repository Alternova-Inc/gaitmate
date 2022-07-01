//
//  ExtensionString.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 1/07/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

extension String{
    func removeSpecialCharsFromString() -> String {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return String(self.filter {okayChars.contains($0) })
    }
}

