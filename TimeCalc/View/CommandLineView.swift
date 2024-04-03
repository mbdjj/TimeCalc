//
//  CommandLineView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 03/04/2024.
//

import SwiftUI

struct CommandLineView: View {
    
    @State var model = CommandLineViewModel()
    
    var body: some View {
        List {
            if model.resultType == CommandComponentResult.self {
                Text("\((model.result as! CommandComponentResult).components.day ?? 0) days")
            }
            
            TextField("Command", text: $model.command)
                .keyboardType(.alphabet)
                .autocorrectionDisabled()
        }
        .navigationTitle("Command line")
        .onChange(of: model.command) { _, _ in
            print(model.commandStringItems)
            print(model.commandItems)
            print(model.commandItems.matches(pattern: [.function, .date, .date]))
            print(model.resultType)
            print(model.result)
        }
    }
}

#Preview {
    NavigationStack {
        CommandLineView()
    }
}
