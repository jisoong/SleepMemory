//
//  AlarmManager.swift
//  Sleeptrack
//
//  Created by 강지수 on 2023/06/16.
//

import Foundation
import SwiftUI

class AlarmManager: ObservableObject {
    @Published var alarmTime = Date()
    @Published var wakeUpText: String?
    
    init() {
        updateWakeUpText()
    }
    
    func setAlarm() {
        updateWakeUpText()
        
        // Perform alarm setting logic here using `alarmTime`
        // For example, you can use a notification to schedule the alarm
        
        // Display an alert to indicate that the alarm is set
        let alertController = UIAlertController(title: "Alarm Set", message: "The alarm is set for \(formatTime(alarmTime))", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    private func updateWakeUpText() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: alarmTime)
        let formatter = DateFormatter()
        formatter.timeStyle = .short

        if let hour = components.hour, let minute = components.minute {
            var wakeUpStartTime: Date?
            if minute >= 30 {
                wakeUpStartTime = calendar.date(bySettingHour: hour, minute: minute - 30, second: 0, of: alarmTime)
            } else {
                let adjustedHour = (hour - 1 + 24) % 24
                wakeUpStartTime = calendar.date(bySettingHour: adjustedHour, minute: minute + 30, second: 0, of: alarmTime)
            }

            let wakeUpEndTime = alarmTime

            let startTimeString = formatter.string(from: wakeUpStartTime ?? alarmTime)
            let endTimeString = formatter.string(from: wakeUpEndTime)

            wakeUpText = "Wake up between \(startTimeString) and \(endTimeString)"
            return
        }

        wakeUpText = nil
    }





    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


