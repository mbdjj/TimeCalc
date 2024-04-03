//
//  CommandLineView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 03/04/2024.
//

import SwiftUI

struct CommandLineView: View {
    
    @State var command = ""
    
    var body: some View {
        List {
            TextField("Command", text: $command)
        }
        .navigationTitle("Command line")
    }
}

#Preview {
    NavigationStack {
        CommandLineView()
    }
}
