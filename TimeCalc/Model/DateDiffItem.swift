//
//  DateDiffItem.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 01/11/2023.
//

import SwiftUI

struct DateDiffItem: Identifiable {
    
    init(fromDate: Date, toDate: Date) {
        self.fromDate = fromDate
        self.toDate = toDate
        
        self.interval = toDate.timeIntervalSince(fromDate)
        
        let interval = fromDate.startOfDay().dateDifferenceComponents(to: toDate.startOfDay())
        self.difference = [
            DateDifference(componentName: "years", value: interval.year),
            DateDifference(componentName: "months", value: interval.month),
            DateDifference(componentName: "days", value: interval.day)
        ]
    }
    
    let fromDate: Date
    let toDate: Date
    
    let interval: Double
    
    let difference: [DateDifference]
    
    var id: String { UUID().uuidString }
}

struct DateDifference: Identifiable {
    let componentName: String
    let value: Int
    
    var id: String { "\(componentName)\(value)" }
}

extension Date {
    func dateDifferenceComponents(to date: Date) -> (year: Int, month: Int, day: Int) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self, to: date)
        return (year: components.year ?? 0, month: components.month ?? 0, day: components.day ?? 0)
    }
    
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}
