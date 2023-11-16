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
                    NavigationLink(value: AppDestination.timeDialView) {
                        Label("Time dial", systemImage: "dial.medium")
                    }
                    NavigationLink(value: AppDestination.dateDifferenceView) {
                        Label("Date difference", systemImage: "plus.forwardslash.minus")
                    }
                } header: {
                    Text("Modes")
                }
            }
            .navigationTitle("Timefly")
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .timeDialView:
                    TimeDialView()
                case .dateDifferenceView:
                    DateDifferenceView()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            NotificationManager.clearBadges()
        }
    }
}

enum AppDestination {
    case timeDialView
    case dateDifferenceView
}

#Preview {
    MainMenuView()
}
