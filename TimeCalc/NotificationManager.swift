//
//  NotificationManager.swift
//  TimeCalc
//
//  Created by Marcin Bartminski on 16/11/2023.
//

import Foundation
import UserNotifications

struct NotificationManager {
    static func requestAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .criticalAlert, .badge, .sound]) { success, error in
            if success {
                print("Notification permission granted :)")
            } else if let error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func scheduleNotification(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Timefly timer is up!"
        content.body = "Your Timefly timer has finished counting down. Do your thing now."
        content.sound = .default
        content.badge = 1
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    static func clearBadges() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
    
    static func getAllScheduledNotifications() async -> [UNNotificationRequest] {
        await withCheckedContinuation { continuation in
            UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
                print("There are \(notifications.count) scheduled notifications")
                continuation.resume(returning: notifications)
            }
        }
    }
    
    static func removeNotification(with id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}

extension UNNotificationRequest: Identifiable {
    public var id: String { identifier }
}
