//
//  NotificationView.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 16/11/2023.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    
    @State var notificationArray = [UNNotificationRequest]()
    
    var body: some View {
        if notificationArray.isEmpty {
            VStack(spacing: 16) {
                Spacer()
                Text("No notifications")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                Text("Couldn't find any scheduled notifications")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                Image(systemName: "bell.slash")
                    .font(.system(size: 72))
                Spacer()
                Spacer()
            }
            .padding()
            .task {
                notificationArray = await NotificationManager.getAllScheduledNotifications()
            }
        } else {
            List {
                ForEach(notificationArray) { notification in
                    let trigger = notification.trigger as! UNCalendarNotificationTrigger
                    let displaySeconds = trigger.dateComponents.second != 0
                    Label((Calendar.current.date(from: trigger.dateComponents)?.formatted(date: .abbreviated, time: displaySeconds ? .standard : .shortened))!, systemImage: "bell")
                        .swipeActions {
                            Button(role: .destructive) {
                                NotificationManager.removeNotification(with: notification.identifier)
                                withAnimation {
                                    notificationArray.removeAll { $0.identifier == notification.identifier }
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                }
            }
            .navigationTitle("Notifications")
        }
    }
}

#Preview {
    NotificationView()
}
