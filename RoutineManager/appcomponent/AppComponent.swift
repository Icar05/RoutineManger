//
//  AppComponent.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import Foundation

public class AppComponent{
    
    
    private let alertUtil = AlertUtil()
    
    private let notificationUtil = NotificationUtil()
    
    private let storage = UserDefaultStorage()
    
    private var elapsedTimeUtil: ElapsedTimeUtil
    
    private var timerUtil: TimerUtil
    
    
    init(){
        self.elapsedTimeUtil = ElapsedTimeUtil(storage: storage)
        self.timerUtil = TimerUtil(
            notificationUtil: notificationUtil,
            soundUtil: SoundUtil(sound: SoundCaf.timerSound()),
            elapsedTimeUtil: elapsedTimeUtil
        )
    }
    
    public func getTimerUtil() ->TimerUtil{
        return  self.timerUtil
    }
    
    public func getNotificationUtil() -> NotificationUtil{
        return self.notificationUtil
    }
    
    public func getAlertUtil() -> AlertUtil{
        return self.alertUtil
    }
}

