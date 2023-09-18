//
//  CalculationHistoryView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 16/09/2023.
//

import SwiftUI

struct CalculationHistoryView: View {
    
    let calculationStrings: [String]
    let calcItems: [CalcHistoryItem]
    
    @State var showOperations: [(String, Bool)]
    
    init(calculationStrings: [String]) {
        self.calculationStrings = calculationStrings
        self.calcItems = calculationStrings
            .map { CalcHistoryItem(decodeString: $0) }
        
        _showOperations = State(initialValue: calcItems.map { ($0.id, false) })
    }
    
    var body: some View {
        NavigationStack {
            List(calcItems) { item in
                Section {
                    let index = showOperations.firstIndex { $0.0 == item.id } ?? 0
                    
                    Button {
                        withAnimation {
                            showOperations[index].1.toggle()
                        }
                    } label: {
                        CalcHistoryMainCell(item: item)
                    }
                    .foregroundStyle(.primary)
                        
                    if showOperations[index].1 {
                        ForEach(item.operations) { operation in
                            Text("\(operation.mathSymbol) \(Int(operation.amount)) \(operation.unit.name)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CalculationHistoryView(calculationStrings: ["1694775798.+m9.+s49.+h112"])
}
