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
        VStack(spacing: 32) {
            Picker("", selection: .constant(0)) {
                Text("Date").tag(0)
                Text("Time").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            HStack {
                DatePicker("", selection: $model.topDate, displayedComponents: .date)
                    .labelsHidden()
                
                Image(systemName: "arrow.right")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                
                DatePicker("", selection: $model.bottomDate, displayedComponents: .date)
                    .labelsHidden()
            }
            
            Spacer()
            
            VStack {
                ForEach(DateDiffItem(fromDate: model.topDate, toDate: model.bottomDate).difference) {
                    if $0.value != 0 {
                        Text("\($0.value) \($0.componentName)")
                            .font(.system(.title, design: .rounded, weight: .bold))
                    }
                }
            }
            
            Spacer()
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
