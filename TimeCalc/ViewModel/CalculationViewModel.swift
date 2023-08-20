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
}
