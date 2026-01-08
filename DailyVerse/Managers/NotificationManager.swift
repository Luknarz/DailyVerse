import Foundation
import UserNotifications
import SwiftUI

final class NotificationManager: NSObject, ObservableObject {
    private enum Keys {
        static let notificationHour = "notification.hour"
        static let notificationMinute = "notification.minute"
    }

    @Published var timeComponents: DateComponents

    override init() {
        let defaults = UserDefaults.standard
        let storedHour = defaults.value(forKey: Keys.notificationHour) as? Int
        let storedMinute = defaults.value(forKey: Keys.notificationMinute) as? Int
        timeComponents = DateComponents(hour: storedHour ?? 8, minute: storedMinute ?? 0)
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
            if granted {
                DispatchQueue.main.async {
                    self.scheduleDailyNotification(at: self.timeComponents)
                }
            }
        }
    }

    func updateNotificationTime(hour: Int, minute: Int) {
        timeComponents.hour = hour
        timeComponents.minute = minute
        let defaults = UserDefaults.standard
        defaults.set(hour, forKey: Keys.notificationHour)
        defaults.set(minute, forKey: Keys.notificationMinute)
        scheduleDailyNotification(at: timeComponents)
    }

    func scheduleDailyNotification(at components: DateComponents) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["dailyVerseReminder"])

        var triggerComponents = DateComponents()
        triggerComponents.hour = components.hour ?? 8
        triggerComponents.minute = components.minute ?? 0

        let content = UNMutableNotificationContent()
        content.title = "Daily Verse"
        content.body = "Take a moment to read today’s verse."
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyVerseReminder", content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            }
        }
    }

    func reminderDate(reference: Date = Date(), calendar: Calendar = .current) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: reference)
        components.hour = timeComponents.hour ?? 8
        components.minute = timeComponents.minute ?? 0
        return calendar.date(from: components) ?? reference
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
