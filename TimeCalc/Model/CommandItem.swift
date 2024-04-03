//
//  CommandItem.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 03/04/2024.
//

import Foundation

class CommandItem {
    let content: String
    
    init(_ content: String) {
        self.content = content
    }
}

class CommandDateItem: CommandItem {
    let date: Date
    let interval: TimeInterval
    
    override init(_ content: String) {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        let formatterDate = formatter.date(from: content) ?? .now
        
        self.date = formatterDate
        self.interval = formatterDate.timeIntervalSince1970
        super.init(content)
    }
    init(_ content: String, date: Date) {
        self.date = date
        self.interval = date.timeIntervalSince1970
        super.init(content)
    }
}

class CommandFunctionItem: CommandItem {
    let type: FunctionType
    
    override init(_ content: String) {
        switch content {
        case "+":
            self.type = .dateAdd
        case "-":
            self.type = .dateAdd
        case "diff":
            self.type = .dateDiff
        default:
            self.type = .none
        }
        super.init(content)
    }
    
    enum FunctionType {
        case dateAdd
        case dateDiff
        
        case none
    }
}

class CommandComponentItem: CommandItem {
    let components: Set<Calendar.Component>
    
    override init(_ content: String) {
        self.components = [.day]
        super.init(content)
    }
}

enum CommandItemType {
    case none
    case date
    case function
    
    var type: CommandItem.Type {
        switch self {
        case .none:
            CommandItem.self
        case .date:
            CommandDateItem.self
        case .function:
            CommandFunctionItem.self
        }
    }
}
