//
//  DateDiffItem.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 01/11/2023.
//

import SwiftUI

struct DateDiffItem: Identifiable {
    
    init(fromDate: Date, toDate: Date, dateMode: Bool) {
        self.fromDate = fromDate
        self.toDate = toDate
        
        self.interval = toDate.timeIntervalSince(fromDate)
        
        if dateMode {
            let dateInterval = fromDate.startOfDay().dateDifferenceComponents(to: toDate.startOfDay())
            self.difference = [
                DateDifference(componentName: "years", value: dateInterval.year),
                DateDifference(componentName: "months", value: dateInterval.month),
                DateDifference(componentName: "days", value: dateInterval.day)
            ]
        } else {
            let dateInterval = fromDate.getRidOfSeconds().allDifferenceComponents(to: toDate.getRidOfSeconds())
            self.difference = [
                DateDifference(componentName: "years", value: dateInterval.year),
                DateDifference(componentName: "months", value: dateInterval.month),
                DateDifference(componentName: "days", value: dateInterval.day),
                DateDifference(componentName: "hours", value: dateInterval.hour),
                DateDifference(componentName: "minutes", value: dateInterval.minute),
                DateDifference(componentName: "seconds", value: dateInterval.second)
            ]
        }
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
