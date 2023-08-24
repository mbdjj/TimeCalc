//
//  CalculationView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 19/08/2023.
//

import SwiftUI

struct CalculationView: View {
    
    @State private var model = CalculationViewModel()
    
    var body: some View {
        VStack {
            Picker("", selection: $model.calculationMode) {
                Text("Date & Time").tag(0)
                Text("Time").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            Spacer()
            
            let sliderValue: Double = floor(abs(model.progress * Double(model.sliderUnit.intValue)))
            Text(String(format: "%.0f", sliderValue))
                .font(.title)
                .bold()
                .padding(.bottom)
                .contentTransition(.numericText())
                .sensoryFeedback(.increase, trigger: sliderValue)
            
            CircularSlider(progress: $model.progress, unit: $model.sliderUnit) {
                let nonAbs: Double = model.progress >= 0 ? 1 : -1
                print(sliderValue * nonAbs)
            }
                .padding(.bottom, 50)
        }
    }
}

#Preview {
    CalculationView()
}
