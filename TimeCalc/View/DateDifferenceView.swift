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
            Picker("", selection: $model.dateMode) {
                Text("Date").tag(0)
                Text("Time").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            HStack {
                DatePicker("", selection: $model.topDate, displayedComponents: model.dateMode == 0 ? .date : .hourAndMinute)
                    .labelsHidden()
                
                Image(systemName: "arrow.right")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                
                DatePicker("", selection: $model.bottomDate, displayedComponents: model.dateMode == 0 ? .date : .hourAndMinute)
                    .labelsHidden()
            }
            
            Menu {
                Button {
                    model.topDate = .now
                } label: {
                    Label("Left", systemImage: "left.circle")
                }
                Button {
                    model.bottomDate = .now
                } label: {
                    Label("Right", systemImage: "right.circle")
                }
            } label: {
                Text("Reset")
            }
            
            Spacer()
            
            VStack {
                ForEach(DateDiffItem(fromDate: model.topDate, toDate: model.bottomDate, dateMode: model.dateMode == 0).difference) {
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
        .onChange(of: model.topDate) {
            if model.topDate > model.bottomDate {
                (model.topDate, model.bottomDate) = (model.bottomDate, model.topDate)
            }
        }
        .onChange(of: model.bottomDate) {
            if model.topDate > model.bottomDate {
                (model.topDate, model.bottomDate) = (model.bottomDate, model.topDate)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DateDifferenceView()
    }
}
