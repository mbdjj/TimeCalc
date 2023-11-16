//
//  TimeDialView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 19/08/2023.
//

import SwiftUI

struct TimeDialView: View {
    
    @State private var model = TimeDialViewModel()
    
    var body: some View {
        VStack {
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
                
                Text(model.timeDate.formatted(date: model.calculationMode == 1 ? .omitted : .abbreviated, time: model.calculationMode == 1 ? model.sliderUnit == .seconds ? .standard : .shortened : .omitted))
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
                    .contentTransition(.numericText(countsDown: !model.increase))
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
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.bottom, 8)
            
            SliderUnitButtons(sliderUnit: $model.sliderUnit, unitOptions: model.unitOptions)
                .minimumScaleFactor(0.6)
            
            CircularSlider(progress: $model.progress, unit: $model.sliderUnit, increase: $model.increase) {
                withAnimation {
                    model.addToDate(sliderValue * nonAbs, unit: model.sliderUnit.component)
                    
                    let sign = nonAbs.sign == .plus ? "+" : "-"
                    model.calcHistory[model.calcHistory.count - 1] += ".\(sign)\(model.sliderUnit.symbol)\(Int(sliderValue))"
                    print(model.calcHistory)
                }
            }
                .padding(.bottom, 50)
        }
        .navigationTitle("Time dial")
        .toolbar {
            Button {
                NotificationManager.requestAuth()
                
                let currentDecodeString = model.calcHistory.last ?? model.calcHistory[0]
                let currentHistoryItem = CalcHistoryItem(decodeString: currentDecodeString)
                
                if currentHistoryItem.usedSeconds {
                    NotificationManager.scheduleNotification(at: model.timeDate)
                } else {
                    NotificationManager.scheduleNotification(at: model.timeDate.getRidOfSeconds())
                }
            } label: {
                Image(systemName: "bell")
                    .symbolVariant(.fill)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.circle)
            .disabled(model.notificationAvailable)
            
            Button {
                withAnimation {
                    model.timeDate = .now
                    model.clearHistory()
                }
            } label: {
                Text("Now")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
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
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            NotificationManager.clearBadges()
        }
    }
}

#Preview {
    TimeDialView()
}
