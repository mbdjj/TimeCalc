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

extension Date {
    func dateDifferenceComponents(to date: Date) -> (year: Int, month: Int, day: Int) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self, to: date)
        return (year: components.year ?? 0, month: components.month ?? 0, day: components.day ?? 0)
    }
    
    func timeDifferenceComponents(to time: Date) -> (hour: Int, minute: Int, second: Int) {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: self, to: time)
        return (hour: components.hour ?? 0, minute: components.minute ?? 0, second: components.second ?? 0)
    }
    
    func allDifferenceComponents(to date: Date) -> (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: date)
        return (
            year: components.year ?? 0,
            month: components.month ?? 0,
            day: components.day ?? 0,
            hour: components.hour ?? 0,
            minute: components.minute ?? 0,
            second: components.second ?? 0
        )
    }
    
    func getRidOfSeconds() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return Calendar.current.date(from: components) ?? self
    }
    
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}
