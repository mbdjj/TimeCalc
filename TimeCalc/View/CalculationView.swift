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
                    
                } label: {
                    Image(systemName: "bell")
                        .symbolVariant(.fill)
                }
                .padding(.top)
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                
                Button {
                    withAnimation {
                        model.timeDate = .now
                        model.clearHistory()
                    }
                } label: {
                    Text("Now")
                }
                .padding(.trailing)
                .padding(.top)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
            Picker("", selection: $model.calculationMode) {
                Text("Date").tag(0)
                Text("Time").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            HStack {
                if model.calculationMode == 1 && model.timeDate.formatted(date: .abbreviated, time: .omitted) != Date().formatted(date: .abbreviated, time: .omitted) {
                    let symbol = Calendar.current.numberOfDaysBetween(Date(), and: model.timeDate) > 0 ? "+" : ""
                    Text("\(symbol)\(Calendar.current.numberOfDaysBetween(Date(), and: model.timeDate))")
                        .bold()
                        .opacity(0)
                }
                
                Text(model.timeDate.formatted(date: model.calculationMode == 1 ? .omitted : .abbreviated, time: model.sliderUnit == .seconds ? .standard : .shortened))
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .contentTransition(.numericText())
                    .padding(.top)
                    .multilineTextAlignment(.center)
                
                if model.calculationMode == 1 && model.timeDate.formatted(date: .abbreviated, time: .omitted) != Date().formatted(date: .abbreviated, time: .omitted) {
                    let symbol = Calendar.current.numberOfDaysBetween(Date(), and: model.timeDate) > 0 ? "+" : ""
                    Text("\(symbol)\(Calendar.current.numberOfDaysBetween(Date(), and: model.timeDate))")
                        .bold()
                }
            }
            .onTapGesture {
                model.showDatePicker = true
            }
            
            let sliderValue: Double = floor(abs(model.progress * Double(model.sliderUnit.intValue)))
            let nonAbs: Double = model.progress >= 0 ? 1 : -1
            
            HStack {
                Image(systemName: nonAbs > 0 ? "plus" : "minus")
                    .font(.title2)
                    .bold()
                    .padding(.bottom)
                
                Text("\(String(format: "%.0f", sliderValue)) \(model.sliderUnit.name)")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                    .contentTransition(.numericText())
                    .sensoryFeedback(.increase, trigger: sliderValue)
            }
            .opacity(sliderValue == 0 ? 0.0 : 1.0)
            .offset(y: sliderValue == 0 ? -36 : 0)
            
            Spacer()
            
            Button {
                model.showCalcHistory = true
            } label: {
                Text("Calculation history")
            }
            
            SliderUnitButtons(sliderUnit: $model.sliderUnit, unitOptions: model.unitOptions)
                .minimumScaleFactor(0.6)
            
            CircularSlider(progress: $model.progress, unit: $model.sliderUnit) {
                withAnimation {
                    model.addToDate(sliderValue * nonAbs, unit: model.sliderUnit.component)
                    
                    let sign = nonAbs.sign == .plus ? "+" : "-"
                    model.calcHistory[model.calcHistory.count - 1] += ".\(sign)\(model.sliderUnit.symbol)\(Int(sliderValue))"
                    print(model.calcHistory)
                }
            }
                .padding(.bottom, 50)
        }
        .sheet(isPresented: $model.showCalcHistory) {
            CalculationHistoryView(calculationStrings: $model.calcHistory)
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $model.showDatePicker) {
            VStack {
                DatePicker("", selection: $model.timeDate)
                    .labelsHidden()
                    .datePickerStyle(.graphical)
                    .padding()
                    .onChange(of: model.timeDate) { _, _ in
                        if model.showDatePicker {
                            model.clearHistory()
                        }
                    }
            }
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    CalculationView()
}
