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
    
    @State var showOperations: [Bool]
    
    init(calculationStrings: [String]) {
        self.calculationStrings = calculationStrings
        self.calcItems = calculationStrings
            .map { CalcHistoryItem(decodeString: $0) }
        
        _showOperations = State(initialValue: calcItems.map { _ in false })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(calcItems.enumerated()), id: \.1.id) { i, item in
                    DisclosureGroup(isExpanded: $showOperations[i]) {
                        ForEach(item.operations) { operation in
                            CalcHistoryOperationCell(operation: operation)
                        }
                    } label: {
                        CalcHistoryMainCell(item: item)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark")
                                .symbolVariant(.fill)
                        }
                        .tint(.yellow)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            //calcItems.remove(at: i)
                        } label: {
                            Image(systemName: "trash")
                                .symbolVariant(.fill)
                        }
                        .tint(.red)
                    }

                }
            }
        }
        .onAppear {
            showOperations[0] = true
        }
    }
}

#Preview {
    CalculationHistoryView(calculationStrings: ["1694775798.+m9.+s49.+h112"])
}
