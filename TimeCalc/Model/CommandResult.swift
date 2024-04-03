//
//  CommandResult.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 03/04/2024.
//

import Foundation

class CommandResult {
    let content: String
    
    init(_ content: String) {
        self.content = content
    }
}

class CommandComponentResult: CommandResult {
    let components: DateComponents
    
    init(components: DateComponents) {
        self.components = components
        super.init("Components")
    }
}
