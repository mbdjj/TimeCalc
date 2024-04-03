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
                    NavigationLink(value: AppDestination.consoleView) {
                        Label("Command line", systemImage: "apple.terminal")
                    }
                    NavigationLink(value: AppDestination.timeDialView) {
                        Label("Time dial", systemImage: "dial.medium")
                    }
                    NavigationLink(value: AppDestination.dateDifferenceView) {
                        Label("Date difference", systemImage: "plus.forwardslash.minus")
                    }
                    NavigationLink(value: AppDestination.timerView) {
                        Label("Timer", systemImage: "timer")
                    }
                } header: {
                    Text("Modes")
                }
                
                Section {
                    NavigationLink(value: AppDestination.manageNotifications) {
                        Label("Manage notifications", systemImage: "app.badge")
                    }
                } header: {
                    Text("Extras")
                }
            }
            .navigationTitle("Timefly")
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .timeDialView:
                    TimeDialView()
                case .dateDifferenceView:
                    DateDifferenceView()
                case .timerView:
                    TimerView()
                case .manageNotifications:
                    NotificationView()
                case .consoleView:
                    CommandLineView()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            NotificationManager.clearBadges()
        }
    }
}

enum AppDestination {
    // Modes
    case timeDialView
    case dateDifferenceView
    case timerView
    case consoleView
    
    // Extras
    case manageNotifications
}

#Preview {
    MainMenuView()
}
