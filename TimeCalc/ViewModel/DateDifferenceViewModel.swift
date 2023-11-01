//
//  DateDifferenceViewModel.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 01/11/2023.
//

import SwiftUI

@Observable class DateDifferenceViewModel {
    var topDate: Date = .now
    var bottomDate: Date = .distantFuture
    
    var showDatePicker: Bool = false
    var datePickerIndex: Int = 0
}
