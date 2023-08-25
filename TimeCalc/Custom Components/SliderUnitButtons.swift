//
//  SliderUnitButtons.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 25/08/2023.
//

import SwiftUI

struct SliderUnitButtons: View {
    
    @Binding var sliderUnit: CircularSliderUnit
    @Binding var unitOptions: [CircularSliderUnit]
    
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
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Button {
                        withAnimation {
                            sliderUnit = unit
                        }
                    } label: {
                        Text(unit.name.capitalized)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview {
    SliderUnitButtons(sliderUnit: .constant(.minutes), unitOptions: .constant([.seconds, .minutes, .hours]))
}
