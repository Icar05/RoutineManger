//
//  ElapsedTimeUtil.swift
//  RS
//
//  Created by ICoon on 29.07.2022.
//

import Foundation

struct ElapsedTimeModel: Codable{
    let startTime: Int
    let maxTime: Int
}

class ElapsedTimeUtil{
    
    
    let storage: UserDefaultStorage
    
    
    init(storage: UserDefaultStorage){
        self.storage = storage
    }
    
    func saveStartTimerTime(maxTime: Int){
        self.storage.saveTime(model: ElapsedTimeModel(startTime: getTime(), maxTime: maxTime.toSeconds()))
    }
    
    func clearStartTimerTime(){
        self.storage.clearTime()
    }
    
    func getCurrentTime() -> ElapsedTimeModel{
        return self.storage.getTime()
    }
    
    func getTimeState() -> (Bool, Int, Int){
        let model = self.storage.getTime()
        
        if(model.maxTime == -1 && model.startTime == -1){
            return (true, -1, -1)
        }
        
        let elapsed = (getTime() - model.startTime) / 1000
        let expired = elapsed >= model.maxTime
        let leftTime = model.maxTime - elapsed
                
        return (expired, elapsed, leftTime)
    }
    
    func getElapsedTime() -> Int{
        return (getTime() - self.storage.getTime().startTime ) / 1000
    }
    
    private func getTime() -> Int {
        return Int(Date().timeIntervalSince1970 * 1000)
    }
    
}


extension Int{
    func toSeconds() -> Int{
        return self * 60
    }
    
    func toMinutes() -> Int{
        return self / 60
    }
}
