//
//  MainMenuView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 31/10/2023.
//

import SwiftUI

struct MainMenuView: View {
    
    @State private var path: [AppDestination] = [.dateAddingView]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    NavigationLink("Time dial", value: AppDestination.dateAddingView)
                    NavigationLink("Date difference", value: AppDestination.dateDifferenceView)
                } header: {
                    Text("Modes")
                }
            }
            .navigationTitle("Timefly")
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .dateAddingView:
                    TimeDialView()
                case .dateDifferenceView:
                    DateDifferenceView()
                }
            }
        }
    }
}

enum AppDestination {
    case dateAddingView
    case dateDifferenceView
}

#Preview {
    MainMenuView()
}
