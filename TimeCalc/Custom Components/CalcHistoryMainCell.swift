//
//  CalcHistoryMainCell.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 18/09/2023.
//

import SwiftUI

struct CalcHistoryMainCell: View {
    
    let item: CalcHistoryItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if !item.sameDay {
                    Text(item.startDate.formatted(date: .abbreviated, time: .omitted))
                }
                Text(item.startDate.formatted(date: .omitted, time: item.usedSeconds ? .standard : .shortened))
            }
            Spacer()
            Image(systemName: "arrow.right")
            Spacer()
            VStack(alignment: .trailing) {
                if !item.sameDay {
                    Text(item.endDate.formatted(date: .abbreviated, time: .omitted))
                }
                Text(item.endDate.formatted(date: .omitted, time: item.usedSeconds ? .standard : .shortened))
            }
        }
        .bold()
    }
}
