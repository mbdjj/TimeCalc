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

class CommandNumberItem: CommandItem {
    let value: Int
    
    override init(_ content: String) {
        self.value = Int(content) ?? 0
        super.init(content)
    }
}

class CommandComponentItem: CommandItem {
    let components: Set<Calendar.Component>
    
    static let possible = ["all", "date", "time", "year", "month", "day", "hour", "minute", "second"]
    
    override init(_ content: String) {
        switch content {
        case "all":
            self.components = [.year, .month, .day, .hour, .minute, .second]
        case "date":
            self.components = [.year, .month, .day]
        case "time":
            self.components = [.hour, .minute, .second]
        case "year":
            self.components = [.year]
        case "month":
            self.components = [.month]
        case "day":
            self.components = [.day]
        case "hour":
            self.components = [.hour]
        case "minute":
            self.components = [.minute]
        case "second":
            self.components = [.second]
        default:
            self.components = []
        }
        super.init(content)
    }
}

enum CommandItemType {
    case none
    case date
    case function
    case component
    case number
    
    var type: CommandItem.Type {
        switch self {
        case .none:
            CommandItem.self
        case .date:
            CommandDateItem.self
        case .function:
            CommandFunctionItem.self
        case .component:
            CommandComponentItem.self
        case .number:
            CommandNumberItem.self
        }
    }
}
