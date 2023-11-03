//
//  CircularSlider.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 19/08/2023.
//

import SwiftUI

struct CircularSlider: View {
    
    @State private var size: CGFloat = 200
    @Binding var progress: CGFloat
    @Binding var unit: CircularSliderUnit
    @State private var angle: Double = 0
    
    @Binding var increase: Bool
    
    @State private var rotations: Int = 0
    @State private var previousAngle: Double = 0
    
    @State private var gestureHappening: Bool = false
    
    let selectionFinished: () -> ()
    
    var body: some View {
        ZStack {
            
            ZStack {
                ForEach(0 ..< unit.intValue, id: \.self) { index in
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 2, height: 15)
                        .offset(y: -size / 2 + 35)
                        .rotationEffect(Angle(degrees: Double(index) * Double(360 / unit.intValue)))
                }
            }
            
            Circle()
                .stroke(Color(uiColor: .systemGray5), style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green.opacity(0.5), style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
            
            if progress <= 0 {
                Circle()
                    .trim(from: 0, to: abs(progress))
                    .stroke(Color.red.opacity(0.5), style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(90))
                    .rotation3DEffect(.degrees(180), axis: (x: 1.0, y: 0.0, z: 0.0))
            }
            
            Circle()
                .foregroundStyle(.primary)
                .frame(width: 40, height: 40)
                .offset(x: size / 2)
                .rotationEffect(.degrees(angle))
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            self.gestureHappening = true
                            self.previousAngle = self.angle
                            
                            let vector = CGVector(dx: value.location.x, dy: value.location.y)
                            let radians = atan2(vector.dy - 20, vector.dx - 20)
                            var angle = radians * 180 / .pi
                            
                            if angle < 0 {
                                angle = 360 + angle
                            }
                            
                            let maxAngle = Double((rotations + 1) * 360)
                            let minAngle = Double(rotations * 360)
                            
                            if previousAngle.inRange(maxAngle - 45 ... maxAngle) && Double(angle + CGFloat(rotations * 360)).inRange(minAngle ... minAngle + 45) {
                                rotations += 1
                            }
                            
                            if previousAngle.inRange(minAngle ... minAngle + 45) && Double(angle + CGFloat(rotations * 360)).inRange(maxAngle - 45 ... maxAngle) {
                                rotations -= 1
                            }
                            
                            withAnimation(.linear(duration: 0.15)) {
                                angle = Double(angle) + Double(rotations * 360)
                                let progress = angle / 360
                                self.increase = abs(progress) > abs(self.progress)
                                self.progress = progress
                                self.angle = angle
                            }
                        }
                        .onEnded { _ in
                            self.gestureHappening = false
                            selectionFinished()
                            
                            withAnimation(.spring()) {
                                self.angle = 0
                                self.progress = 0
                                
                                self.rotations = 0
                                self.previousAngle = 0
                            }
                        }
                )
                .rotationEffect(.degrees(-90))
                .sensoryFeedback(.start, trigger: gestureHappening)
        }
        .padding(40)
    }
}

enum CircularSliderUnit: String, CaseIterable {
    case seconds = "60s"
    case minutes = "60m"
    case hours = "12h"
    case days = "7d"
    case months = "12M"
    case years = "10y"
}
extension CircularSliderUnit {
    var intValue: Int {
        let stringInt = self.rawValue.dropLast()
        return Int(stringInt) ?? 1
    }
    
    var symbol: String {
        return "\(self.rawValue.last ?? "e")"
    }
    
    var name: String {
        switch self {
        case .seconds: "seconds"
        case .minutes: "minutes"
        case .hours: "hours"
        case .days: "days"
        case .months: "months"
        case .years: "years"
        }
    }
    
    var component: Calendar.Component {
        switch self {
        case .seconds: .second
        case .minutes: .minute
        case .hours: .hour
        case .days: .day
        case .months: .month
        case .years: .year
        }
    }
}

extension [CircularSliderUnit] {
    static let timeOnly: [CircularSliderUnit] = [.seconds, .minutes, .hours]
    static let dateOnly: [CircularSliderUnit] = [.days, .months, .years]
    static let dateAndTime: [CircularSliderUnit] = [.minutes, .hours, .days, .months, .years]
}

extension Double {
    func inRange(_ range: ClosedRange<Double>) -> Bool {
        return self >= range.lowerBound && self <= range.upperBound
    }
}

#Preview {
    CircularSlider(progress: .constant(0), unit: .constant(.hours), increase: .constant(true)) {}
}
