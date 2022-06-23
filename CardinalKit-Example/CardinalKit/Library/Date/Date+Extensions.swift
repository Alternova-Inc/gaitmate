//
//  Date+Extensions.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 8/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

extension Date{
    func addDays(days:Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = days
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)
        return futureDate!
    }
    
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func hour() -> Int? {
        return Calendar.current.dateComponents([.hour], from: self).hour
    }
    
    func weekNumber() -> Int? {
        return Calendar.current.dateComponents([.weekOfYear], from: self).weekOfYear
    }
    
    func toString(dateFormat: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat ?? "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

extension String{
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: self)
        if let date = date {
            return date
        }
        else {
            return Date()
        }
    }
}
