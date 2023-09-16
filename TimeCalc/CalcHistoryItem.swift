//
//  CalcHistoryItem.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 16/09/2023.
//

import Foundation

struct CalcHistoryItem: Identifiable {
    
    init(decodeString: String) {
        self.decodeString = decodeString
        
        let allOperations = decodeString.components(separatedBy: ".")
        self.startDate = Date(timeIntervalSince1970: Double(allOperations[0]) ?? 0)
        
        self.operations = allOperations
            .reversed()
            .dropLast()
            .reversed()
        
        self.usedSeconds = operations.contains {
            let startIndex = $0.index($0.startIndex, offsetBy: 1)
            let endIndex = $0.index(after: startIndex)
            return $0[startIndex ..< endIndex] == "s"
        }
    }
    
    let decodeString: String
    
    let startDate: Date
    var endDate: Date {
        var date = startDate
        operations.forEach { date = addTo(date: date, operation: $0) }
        return date
    }
    
    let operations: [String]
    
    let usedSeconds: Bool
    
    var id: String { return decodeString }
    
    
    private func addTo(date: Date, operation: String) -> Date {
        let calcOperation = CalcHistoryOperation(decodeString: operation)
        return Calendar.current.date(byAdding: calcOperation.unit.component, value: Int(calcOperation.value), to: date) ?? date
    }
}

struct CalcHistoryOperation {
    //+m9
    
    init(decodeString: String) {
        self.decodeString = decodeString
    }
    
    let decodeString: String
    
    private var mathSymbol: String { return "\(decodeString.first ?? "+")"}
    private var unitSymbol: String {
        let startIndex = decodeString.index(decodeString.startIndex, offsetBy: 1)
        let endIndex = decodeString.index(decodeString.startIndex, offsetBy: 2)
        return "\(decodeString[startIndex ..< endIndex])"
    }
    private var amount: Double {
        let startIndex = decodeString.index(decodeString.startIndex, offsetBy: 2)
        let endIndex = decodeString.endIndex
        return Double("\(decodeString[startIndex ..< endIndex])") ?? 0
    }
    
    var unit: CircularSliderUnit {
        return CircularSliderUnit.allCases.first { $0.symbol == "\(unitSymbol)" } ?? .minutes
    }
    var value: Double {
        let multiplier: Double = mathSymbol == "+" ? 1 : -1
        return amount * multiplier
    }
}
