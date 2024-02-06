//
//  TimerView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 02/11/2023.
//

import SwiftUI

struct TimerView: View {
    
    @State var progress: CGFloat = 0
    @State var unit: CircularSliderUnit = .seconds
    @State var increase: Bool = true
    
    @State var timerSet: Bool = false
    @State var count: Double = 0
    @State var initialCount: Double = 0
    @State var timerProgress: CGFloat = 1
    
    @Namespace var animation
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            CircularSlider(progress: timerSet ? $timerProgress : $progress, unit: timerSet ? .constant(.none) : $unit, increase: $increase, allowGesture: !timerSet) {
                withAnimation {
                    timerSet = true
                    let sliderValue = floor(abs(progress * Double(unit.intValue) * unit.intervalMultiplier))
                    print(sliderValue)
                    initialCount = sliderValue
                    count = sliderValue
                }
            }
            .onReceive(timer) { _ in
                withAnimation {
                    if count > 0 {
                        count -= 1
                    } else {
                        timerSet = false
                    }
                }
            }
            .offset(y: timerSet ? -100 : 0)
        }
        .navigationTitle("Timer")
        .onChange(of: count) { _, _ in
            timerProgress = count / initialCount
        }
    }
}

#Preview {
    TimerView()
}
