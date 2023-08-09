//
//  TimerBackgroundUtil.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import Foundation
import UserNotifications

public final class NotificationUtil{
    
    
    
    private let showLogs = false
    
    private let log = "NotificationUtil"
    
    
    
    /**
        check notification permissins
     */
    func checkNotificationPermission(doIfNotPermitted: @escaping () -> Void){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (bool, error) in
            self.printLog("Permission -> permitted: \(bool), error: \(String(describing: error))")
            
            if(!bool){
               doIfNotPermitted()
            }
        }
    }
    
    /**
        register and cancel notifications
     */
    
    func clearDeliveredNotifications(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        self.printLog("clearDeliveredNotifications")
    }
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
        self.printLog("cancelNotification")
    }
    
    func sceduleNotification(maxTimeInMinutes: Int){
    
        let soundName = UNNotificationSoundName("\(SoundCaf.timerSound().rawValue).mp3")
        let sound = UNNotificationSound(named: soundName)
        let time: Double = Double(maxTimeInMinutes.toSeconds())
        let content =  UNMutableNotificationContent()
            content.body = "Время вышло"
            content.sound = sound
                    
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
        
        printLog("sound: \(sound)")
             
        
        UNUserNotificationCenter.current().add(request) { [self] (error) in
            if (error != nil) {
                printLog("sceduleNotification: error: \(String(describing: error))")
            } else {
                printLog("sceduleNotification: time \(maxTimeInMinutes) minutes")
            }
        }
    }
    
    private func printLog(_ value: String){
        if(showLogs){
            print("\(log): \(value)")
        }
    }
    
}
