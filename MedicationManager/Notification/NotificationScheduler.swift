//
//  NotificationScheduler.swift
//  MedicationManager
//
//  Created by Tasuku Yamamoto on 4/20/22.
//

import Foundation
import UserNotifications

class NotificationScheduler{
    //MARK: - Methods
    func scheduleNotification(for medication: Medication){
        guard let medicationID = medication.id,
              !medicationID.isEmpty
        else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "It's time to take your \(medication.name ?? "Medication")"
        content.sound = .defaultRingtone
        content.userInfo = [Strings.medicationIDKey : medicationID]
        content.categoryIdentifier = Strings.notificationCategoryIdentifier
        
        let fireDateComponents = Calendar.current.dateComponents([.hour, .minute], from: medication.timeOfDay ?? Date())
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: medicationID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotification(for medication: Medication){
        guard let medicationID = medication.id,
              !medicationID.isEmpty
        else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [medicationID])
    }
    
    
}//End of class
