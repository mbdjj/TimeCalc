//
//  DateAndTimeManager.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 03/04/2024.
//

import Foundation

struct DateAndTimeManager {
    static func addTo(_ date: Date, component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: date) ?? date
    }
    static func dateDiff(_ lhs: Date, _ rhs: Date, components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: lhs, to: rhs)
    }
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
