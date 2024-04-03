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
    var resultType: CommandResult.Type = CommandResult.self
    
    func decodeCommandItem(_ content: String) -> CommandItem {
        switch content {
        case "now":
            return CommandDateItem(content, date: .now)
        case let s where s.matches(/\d{4}-\d{2}-\d{2}/):
            return CommandDateItem(content)
        case "diff":
            return CommandFunctionItem(content)
        default:
            return CommandItem(content)
        }
    }
    
    func decodeResult(items: [CommandItem]) -> CommandResult? {
        if items.matches(pattern: [.function, .date, .date]) {
            guard (items[0] as! CommandFunctionItem).type == .dateDiff else {
                resultType = CommandResult.self
                return nil
            }
            let components = DateAndTimeManager.dateDiff((items[1] as! CommandDateItem).date, (items[2] as! CommandDateItem).date, components: [.year, .month, .day])
            resultType = CommandComponentResult.self
            return CommandComponentResult(components: components)
        } else {
            resultType = CommandResult.self
            return nil
        }
    }
}

extension String {
    func matches(_ regex: Regex<Substring>) -> Bool {
        (try? regex.wholeMatch(in: self)) != nil
    }
}

extension [CommandItem] {
    func matches(pattern: [CommandItemType]) -> Bool {
        if self.count < pattern.count { return false }
        
        let match = zip(self, pattern)
            .map { type(of: $0) == $1.type.self }
            .reduce(true, { $0 && $1 })
        return match
    }
}
