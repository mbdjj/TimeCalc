//
//  CommandLineViewModel.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 03/04/2024.
//

import Foundation

@Observable class CommandLineViewModel {
    var command: String = ""
    var commandStringItems: [String] { command.components(separatedBy: " ").map { $0.lowercased() } }
    var commandItems: [CommandItem] { commandStringItems.map { decodeCommandItem($0) } }
    
    var result: CommandResult? { decodeResult(items: commandItems) }
    
    func decodeCommandItem(_ content: String) -> CommandItem {
        switch content {
        case "now":
            return CommandDateItem(content, date: .now)
        case let s where s.matches(/\d{4}-\d{2}-\d{2}/):
            return CommandDateItem(content)
        case let s where ["diff", "+", "-"].contains(s):
            return CommandFunctionItem(content)
        case let s where CommandComponentItem.possible.contains(s):
            return CommandComponentItem(content)
        case let s where s.matches(/\d{1,}/):
            return CommandNumberItem(content)
        default:
            return CommandItem(content)
        }
    }
    
    func decodeResult(items: [CommandItem]) -> CommandResult? {
        if items.matches(pattern: [.function, .date, .date]) {
            guard (items[0] as! CommandFunctionItem).type == .dateDiff else {
                return nil
            }
            let lhs = items[1] as! CommandDateItem
            let rhs = items[2] as! CommandDateItem
            
            let components = DateAndTimeManager.dateDiff(lhs.date, rhs.date, components: [.day])
            return CommandComponentResult(components: components)
        } else if items.matches(pattern: [.function, .date, .date, .component]) {
            guard (items[0] as! CommandFunctionItem).type == .dateDiff else {
                return nil
            }
            let lhs = items[1] as! CommandDateItem
            let rhs = items[2] as! CommandDateItem
            let comp = items[3] as! CommandComponentItem
            
            let components = DateAndTimeManager.dateDiff(lhs.date, rhs.date, components: comp.components)
            return CommandComponentResult(components: components)
        } else if items.matches(pattern: [.date, .function, .number, .component]) {
            guard (items[1] as! CommandFunctionItem).type == .dateAdd else {
                return nil
            }
            
            let lhs = items[0] as! CommandDateItem
            let sign = items[1] as! CommandFunctionItem
            let num = items[2] as! CommandNumberItem
            let comp = items[3] as! CommandComponentItem
            
            let value = sign.content == "-" ? num.value * -1 : num.value
            let date = DateAndTimeManager.addTo(lhs.date, component: comp.components.first ?? .day, value: value)
            return CommandDateResult(date: date)
        }
        return nil
    }
}

extension String {
    func matches(_ regex: Regex<Substring>) -> Bool {
        (try? regex.wholeMatch(in: self)) != nil
    }
}

extension [CommandItem] {
    func matches(pattern: [CommandItemType]) -> Bool {
        if self.count != pattern.count { return false }
        
        let match = zip(self, pattern)
            .map { type(of: $0) == $1.type.self }
            .reduce(true, { $0 && $1 })
        return match
    }
}
