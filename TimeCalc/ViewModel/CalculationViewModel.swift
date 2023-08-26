//
//  CalculationViewModel.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 20/08/2023.
//

import SwiftUI

@Observable class CalculationViewModel {
    var calculationMode = 1
    var progress: CGFloat = 0
    var sliderUnit: CircularSliderUnit = .minutes
    
    var timeDate: Date = .now
    var calcHistory: String = String(format: "%.0f", Date().timeIntervalSince1970)
    
    var unitOptions: [CircularSliderUnit] {
        calculationMode == 1 ? [CircularSliderUnit].timeOnly : [CircularSliderUnit].dateAndTime
    }
    
    @MainActor func addToDate(_ value: Double, unit: Calendar.Component) {
        timeDate = Calendar.current.date(byAdding: unit, value: Int(value), to: timeDate) ?? .now
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
