//
//  CalculationHistoryView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 16/09/2023.
//

import SwiftUI

struct CalculationHistoryView: View {
    
    let calculationString: String
    let calcItem: CalcHistoryItem
    
    init(calculationString: String) {
        self.calculationString = calculationString
        self.calcItem = CalcHistoryItem(decodeString: calculationString)
    }
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    VStack {
                        Text(calcItem.startDate.formatted(date: .abbreviated, time: .omitted))
                        Text(calcItem.startDate.formatted(date: .omitted, time: calcItem.usedSeconds ? .standard : .shortened))
                    }
                    Image(systemName: "arrow.right")
                    VStack {
                        Text(calcItem.endDate.formatted(date: .abbreviated, time: .omitted))
                        Text(calcItem.endDate.formatted(date: .omitted, time: calcItem.usedSeconds ? .standard : .shortened))
                    }
                }
            }
        }
    }
}

#Preview {
    CalculationHistoryView(calculationString: "1694775798.+m9.+s49.+h112")
}
