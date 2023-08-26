//
//  SliderUnitButtons.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 25/08/2023.
//

import SwiftUI

struct SliderUnitButtons: View {
    
    @Binding var sliderUnit: CircularSliderUnit
    var unitOptions: [CircularSliderUnit]
    
    var body: some View {
        HStack {
            ForEach(unitOptions, id: \.self) { unit in
                if sliderUnit == unit {
                    Button {
                        withAnimation {
                            sliderUnit = unit
                        }
                    } label: {
                        Text(unit.name.capitalized)
                            .lineLimit(1)
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Button {
                        withAnimation {
                            sliderUnit = unit
                        }
                    } label: {
                        Text(unit.name.capitalized)
                            .lineLimit(1)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview {
    SliderUnitButtons(sliderUnit: .constant(.minutes), unitOptions: [.seconds, .minutes, .hours])
}
