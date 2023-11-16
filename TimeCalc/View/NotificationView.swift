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
        List {
            ForEach(notificationArray) { notification in
                let trigger = notification.trigger as! UNCalendarNotificationTrigger
                Label((Calendar.current.date(from: trigger.dateComponents)?.formatted(date: .abbreviated, time: .standard))!, systemImage: "bell.fill")
                    .swipeActions {
                        Button(role: .destructive) {
                            NotificationManager.removeNotification(with: notification.identifier)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
            }
        }
        .navigationTitle("Notifications")
        .task {
            notificationArray = await NotificationManager.getAllScheduledNotifications()
        }
    }
}

#Preview {
    NotificationView()
}
