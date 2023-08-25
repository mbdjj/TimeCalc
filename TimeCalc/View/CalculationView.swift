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
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        model.timeDate = .now
                    }
                } label: {
                    Text("Now")
                }
                .padding(.horizontal)
                .padding(.top)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
            Picker("", selection: $model.calculationMode) {
                Text("Date & Time").tag(0)
                Text("Time").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Text(model.timeDate.formatted(date: .omitted, time: .shortened))
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .contentTransition(.numericText())
            
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
                
                withAnimation {
                    model.addToDate(sliderValue * nonAbs, unit: .minute)
                }
            }
                .padding(.bottom, 50)
        }
    }
}

#Preview {
    CalculationView()
}
