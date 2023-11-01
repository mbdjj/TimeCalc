//
//  DateDifferenceView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 01/11/2023.
//

import SwiftUI

struct DateDifferenceView: View {
    
    @State private var model = DateDifferenceViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Picker("", selection: .constant(0)) {
                Text("Date").tag(0)
                Text("Time").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Text(model.topDate.formatted(date: .abbreviated, time: .omitted))
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            Image(systemName: "arrow.down")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            Text(model.bottomDate.formatted(date: .abbreviated, time: .omitted))
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            Image(systemName: "equal")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                .rotationEffect(.degrees(90))
            
            VStack {
                ForEach(DateDiffItem(fromDate: model.topDate, toDate: model.bottomDate).difference) {
                    Text("\($0.value) \($0.componentName)")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                }
            }
            
            Spacer()
        }
        .navigationTitle("Date difference")
    }
}

#Preview {
    NavigationStack {
        DateDifferenceView()
    }
}
