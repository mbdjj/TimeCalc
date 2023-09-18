//
//  CalcHistoryOperationCell.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 18/09/2023.
//

import SwiftUI

struct CalcHistoryOperationCell: View {
    
    let operation: CalcHistoryOperation
    
    var body: some View {
        HStack {
            Text("\(operation.mathSymbol) \(Int(operation.amount)) \(operation.unit.name)")
            
            Spacer()
            
            VStack(alignment: .trailing) {
                if !operation.sameDay {
                    Text(operation.endDate.formatted(date: .abbreviated, time: .omitted))
                }
                Text(operation.endDate.formatted(date: .omitted, time: /*item.usedSeconds ? .standard : */.shortened))
            }
        }
    }
}
