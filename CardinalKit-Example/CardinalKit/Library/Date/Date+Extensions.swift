//
//  Date+Extensions.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 8/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

extension Date{
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func hour() -> Int? {
        return Calendar.current.dateComponents([.hour], from: self).hour
    }
    
    func weekNumber() -> Int? {
        return Calendar.current.dateComponents([.weekOfYear], from: self).weekOfYear
    }
}
