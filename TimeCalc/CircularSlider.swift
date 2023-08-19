//
//  CircularSlider.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 19/08/2023.
//

import SwiftUI

struct CircularSlider: View {
    
    @State private var size: CGFloat = 200
    @State var progress: CGFloat = 0
    @State private var angle: Double = 0
    
    var body: some View {
        ZStack {
            
            ZStack {
                ForEach(0 ... 24, id: \.self) { index in
                    Rectangle()
                        .fill(index % 2 == 0 ? Color.primary : .gray)
                        .frame(width: 2, height: index % 2 == 0 ? 15 : 4)
                        .offset(y: size / 2 - 35)
                        .rotationEffect(Angle(degrees: Double(index) * 15))
                }
            }
            
            Circle()
                .stroke(Color(uiColor: .systemGray5), style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                .frame(width: size, height: size)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green.opacity(0.2), style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .foregroundStyle(.primary)
                .frame(width: 40, height: 40)
                .offset(x: size / 2)
                .rotationEffect(.degrees(angle))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let vector = CGVector(dx: value.location.x, dy: value.location.y)
                            let radians = atan2(vector.dy - 20, vector.dx - 20)
                            var angle = radians * 180 / .pi
                            
                            if angle < 0 {
                                angle = 360 + angle
                            }
                            
                            withAnimation(.linear(duration: 0.15)) {
                                let progress = angle / 360
                                print(progress)
                                self.progress = progress
                                self.angle = Double(angle)
                            }
                        }
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

#Preview {
    CircularSlider()
}
