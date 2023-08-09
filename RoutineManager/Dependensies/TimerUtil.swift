//
//  TimerUtil.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import Foundation
import AVKit

struct TimerUtilState{
    let state: TimerState
    let maxTime: Int
}

public protocol TimerUtilDelegate: NSObject{
    func onTimerStart()
    func onTimerUpdate(current: Int, max: Int)
    func onTimerFinished(maxValue: Int)
    func onTimerStop(maxValue: Int)
    func needDebug(value: String)
}

let notificationIdentifier = "TimerNotification"



public class TimerUtil{
    
    
    
    
    private let elapsedTimeUtil: ElapsedTimeUtil
    
    private let soundUtil: SoundUtil
    
    private let notificationUtil: NotificationUtil
    
    private let showLogs = false
    
    private let log = "TimerUtil"
    
    private var maxTimeInMinutes = 16
    
    private var timer: Timer? = nil
    
    private var timerValue = 0
    
    private var state: TimerState = .CLEAR
    
    weak var delegate: TimerUtilDelegate? = nil
    
    
    
    init(notificationUtil: NotificationUtil, soundUtil: SoundUtil, elapsedTimeUtil: ElapsedTimeUtil){
        self.notificationUtil = notificationUtil
        self.soundUtil = soundUtil
        self.elapsedTimeUtil = elapsedTimeUtil
        
        NotificationCenter.default.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appGoneToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
   
    func setMaxTime(maxTimeInMinutes: Int){
        self.maxTimeInMinutes = maxTimeInMinutes
    }
    
    func getState() -> TimerUtilState{
        return TimerUtilState(
            state: state,
            maxTime: maxTimeInMinutes)
    }
    
    func startTimer(){
        self.state = .STARTED
        self.notificationUtil.sceduleNotification(maxTimeInMinutes: maxTimeInMinutes)
        self.timerValue = maxTimeInMinutes.toSeconds()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
        self.elapsedTimeUtil.saveStartTimerTime(maxTime: maxTimeInMinutes)
        self.delegate?.onTimerStart()
        
        printLog("startTimer, time: \(elapsedTimeUtil.getCurrentTime())")
    }
    
    func finishTimer(){
        self.state = .FINISHED
        self.notificationUtil.cancelNotification()
        self.timer?.invalidate()
        self.timer = nil
        self.elapsedTimeUtil.clearStartTimerTime()
        self.delegate?.onTimerFinished(maxValue: maxTimeInMinutes.toSeconds())
        
        printLog("finishTimer, time: \(elapsedTimeUtil.getCurrentTime())")
    }
    
    func stopTimer(){
        self.state = .CLEAR
        self.notificationUtil.cancelNotification()
        self.timer?.invalidate()
        self.timer = nil
        self.elapsedTimeUtil.clearStartTimerTime()
        self.delegate?.onTimerStop(maxValue: maxTimeInMinutes.toSeconds())
        
        printLog("stopTimer, time: \(elapsedTimeUtil.getCurrentTime())")
    }
    
    func stopSound(){
        self.soundUtil.stop()
    }
    
    func refreshTimer(){
        self.soundUtil.stop()
        self.state = .CLEAR
        self.delegate?.onTimerStop(maxValue: maxTimeInMinutes.toSeconds())
    }
    
    func isTimerStarted() -> Bool {
        return self.timer != nil
    }
    
    @objc func timerUpdate() {
        
        self.timerValue -= 1
        self.delegate?.onTimerUpdate(current: timerValue, max: maxTimeInMinutes.toSeconds())
        
        printLog("timerUpdate: \(timerValue)")
        
        if(timerValue == 0){
            self.finishTimer()
            self.soundUtil.play()
        }
    }
    
    @objc func appGoneToBackground() {
        printLog("app in background!")
    }
    
    @objc func appCameToForeground() {
        printLog("app in foreground!")
        
        let elapsedState = self.elapsedTimeUtil.getTimeState()
        self.debugExpiredState(elapsedState: elapsedState)
        
        if(elapsedState.0){
            self.timerHasFinishedInBackground()
        }else{
            self.timerHasUpdatedInBackground(elapsedTime: elapsedState.1, left: elapsedState.2)
        }

    }
    
    //write debug about expiration
    private func debugExpiredState(elapsedState: (Bool, Int, Int)){
        printLog("results: \(elapsedState)")
    }
    
    //timer needs new update
    private func timerHasUpdatedInBackground(elapsedTime: Int, left: Int){
        printLog("timer has not finished: \(elapsedTime) / \(maxTimeInMinutes.toSeconds())")
        self.timerValue = left
        self.delegate?.onTimerUpdate(current: timerValue, max: maxTimeInMinutes.toSeconds())
    }
    
    // we have to notify timer about finish
    private func timerHasFinishedInBackground(){
        printLog("timer has finished !")
        if(!finishAlreadyHandled()){
            self.finishTimer()
            self.notificationUtil.clearDeliveredNotifications()
        }
    }
    
    //check if state has already been handled, to no needs to hangdle it again
    private func finishAlreadyHandled() -> Bool{
        return self.state == .CLEAR || self.state == .FINISHED
    }

    
    private func printLog(_ value: String){
        if(showLogs){
            print("\(log): \(value)")
        }
    }
}

