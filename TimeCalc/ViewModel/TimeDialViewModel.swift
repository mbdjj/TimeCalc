//
//  TimeDialViewModel.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 20/08/2023.
//

import SwiftUI

@Observable class TimeDialViewModel {
    
    var calculationMode = 1
    var progress: CGFloat = 0
    var sliderUnit: CircularSliderUnit = .minutes
    var increase: Bool = true
    
    var timeDate: Date = .now
    var calcHistory: [String] = [String(format: "%.0f", floor(Date().timeIntervalSince1970))]
    
    var showDatePicker: Bool = false
    var showCalcHistory: Bool = false
    
    var unitOptions: [CircularSliderUnit] {
        calculationMode == 1 ? [CircularSliderUnit].timeOnly : [CircularSliderUnit].dateOnly
    }
    
    @MainActor func addToDate(_ value: Double, unit: Calendar.Component) {
        timeDate = Calendar.current.date(byAdding: unit, value: Int(value), to: timeDate) ?? .now
    }
    
    func clearHistory() {
        calcHistory = calcHistory.filter { $0.contains(".") }
        calcHistory.append(String(format: "%.0f", floor(timeDate.timeIntervalSince1970)))
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
}
