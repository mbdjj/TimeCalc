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
    
    @MainActor func addToDate(_ value: Double, unit: Calendar.Component) {
        timeDate = Calendar.current.date(byAdding: unit, value: Int(value), to: timeDate) ?? .now
    }
}
