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
            Section {
                VStack {
                    if let res = model.result as? CommandComponentResult {
                        if let year = res.components.year {
                            Text("\(Int(abs(year))) years")
                        }
                        if let month = res.components.month {
                            Text("\(Int(abs(month))) months")
                        }
                        if let day = res.components.day {
                            Text("\(Int(abs(day))) days")
                        }
                        if let hour = res.components.hour {
                            Text("\(Int(abs(hour))) hours")
                        }
                        if let minute = res.components.minute {
                            Text("\(Int(abs(minute))) minutes")
                        }
                        if let second = res.components.second {
                            Text("\(Int(abs(second))) seconds")
                        }
                    } else if let res = model.result as? CommandDateResult {
                        Text(res.date.formatted(date: .abbreviated, time: .standard))
                    }
                }
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
            print(type(of: model.result))
            print(model.result)
        }
    }
}

#Preview {
    NavigationStack {
        CommandLineView()
    }
}
