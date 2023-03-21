import Foundation
import UserNotifications

public class Notifications {
    private static var center = UNUserNotificationCenter.current()
    
    public static func requestPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public static func sendNotification(for birthday: Birthday) {
        guard let date = birthday.date,
              let contact = birthday.contact(),
              let id = birthday.id?.uuidString
        else {
            return
        }
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.day, .month, .year], from: date),
            repeats: true
        )
        
        let content = UNMutableNotificationContent()
        let name = contact.getFullName()
        let suffix = name.last! == "s"
        content.title = "It's \(name)\(suffix) birthday today!"
        content.body = "Make sure to wish them a good day."
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        center.add(request)
    }
    
    public static func cancelNotification(for birthday: Birthday) {
        guard let id = birthday.id?.uuidString else {
            return
        }
        
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }
}
