//
//  CalculationHistoryView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 16/09/2023.
//

import SwiftUI

struct CalculationHistoryView: View {
    
    @Binding var calculationStrings: [String]
    var calcItems: [CalcHistoryItem] {
        calculationStrings.map { CalcHistoryItem(decodeString: $0) }.reversed()
    }
    
    @State var showOperations: [Bool]
    
    @AppStorage("calcStrings") var savedCalcStrings: String = ""
    
    init(calculationStrings: Binding<[String]>) {
        _calculationStrings = calculationStrings
        _showOperations = State(initialValue: calculationStrings.map { _ in false })
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
                        let isSaved = savedCalcStrings.contains(item.id)
                        Button {
                            if isSaved {
                                savedCalcStrings = savedCalcStrings
                                    .replacingOccurrences(of: item.id, with: "")
                                    .replacingOccurrences(of: ",,", with: ",")
                                    .removeFirstComma()
                                print(savedCalcStrings)
                            } else {
                                savedCalcStrings += "\(savedCalcStrings == "" ? "" : ",")\(item.id)"
                            }
                        } label: {
                            Image(systemName: isSaved ? "bookmark.slash" : "bookmark")
                                .symbolVariant(.fill)
                        }
                        .tint(.yellow)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            if i != 0 {
                                let removeIndex = calculationStrings.count - i - 1
                                calculationStrings.remove(at: removeIndex)
                                showOperations.remove(at: i)
                            }
                        } label: {
                            Image(systemName: "trash")
                                .symbolVariant(.fill)
                        }
                        .tint(i != 0 ? .red : .gray)
                    }

                }
            }
            .navigationTitle("History")
        }
        .onAppear {
            showOperations[0] = true
        }
    }
}

#Preview {
    CalculationHistoryView(calculationStrings: .constant(["1694775798.+m9.+s49.+h112"]))
}

extension String {
    func removeFirstComma() -> String {
        var text = self
        if text.first == "," {
            text.remove(at: self.startIndex)
        }
        return text
    }
}
