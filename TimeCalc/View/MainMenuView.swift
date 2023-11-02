//
//  MainMenuView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 31/10/2023.
//

import SwiftUI

struct MainMenuView: View {
    
    @State private var path: [AppDestination] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    NavigationLink("Time dial", value: AppDestination.dateAddingView)
                    NavigationLink("Date difference", value: AppDestination.dateDifferenceView)
                    NavigationLink("Change units", value: AppDestination.unitChangeView)
                        .disabled(true)
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
                case .unitChangeView:
                    UnitChangeView()
                }
            }
        }
    }
}

enum AppDestination {
    case dateAddingView
    case dateDifferenceView
    case unitChangeView
}

#Preview {
    MainMenuView()
}
