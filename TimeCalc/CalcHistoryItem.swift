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
        
        self.operationStrings = allOperations
            .reversed()
            .dropLast()
            .reversed()
        
        self.usedSeconds = operationStrings.contains {
            let startIndex = $0.index($0.startIndex, offsetBy: 1)
            let endIndex = $0.index(after: startIndex)
            return $0[startIndex ..< endIndex] == "s"
        }
        
        var date = startDate
        operations = []
        for operationString in operationStrings {
            let operation = CalcHistoryOperation(decodeString: operationString, startDate: date)
            operations.append(operation)
            date = operation.endDate
        }
    }
    
    let decodeString: String
    
    let startDate: Date
    var endDate: Date { operations.last?.endDate ?? startDate }
    
    private let operationStrings: [String]
    var operations: [CalcHistoryOperation]
    
    let usedSeconds: Bool
    
    var id: String { return decodeString }
    
}

struct CalcHistoryOperation: Identifiable {
    
    init(decodeString: String, startDate: Date) {
        self.decodeString = decodeString
        self.startDate = startDate
    }
    
    let decodeString: String
    let startDate: Date
    
    var endDate: Date {
        Calendar.current.date(byAdding: unit.component, value: Int(value), to: startDate) ?? startDate
    }
    
    var mathSymbol: String { return "\(decodeString.first ?? "+")"}
    private var unitSymbol: String {
        let startIndex = decodeString.index(decodeString.startIndex, offsetBy: 1)
        let endIndex = decodeString.index(decodeString.startIndex, offsetBy: 2)
        return "\(decodeString[startIndex ..< endIndex])"
    }
    var amount: Double {
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
    
    let id = UUID()
}
