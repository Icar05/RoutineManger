//
//  UserDefaultsStorage.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 13.10.2021.
//

import Foundation

struct UserDefaultConstants{
    public static var models = "Models"
    public static var appPreferences = "AppPreferences"
    public static var time = "Time"
}

class UserDefaultStorage{
    
    
    
    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    

    /**
     time
     */
    @discardableResult
    func saveTime(model: ElapsedTimeModel) -> Bool{
        do {
            let data = try encoder.encode(model)
            UserDefaults.standard.set(data, forKey: UserDefaultConstants.time)
            return true
        } catch {
            print("Unable to Encode ElapsedTimeModel (\(error))")
            return false
        }
    }
    
    func getTime() -> ElapsedTimeModel{
        if let data = UserDefaults.standard.data(forKey: UserDefaultConstants.time) {
            do {
                return try decoder.decode(ElapsedTimeModel.self, from: data)
            } catch {
                print("Unable to Decode ElapsedTimeModel (\(error))")
                return getDefaultElapsedTimeModel()
            }
        }
        return getDefaultElapsedTimeModel()
    }
    
    @discardableResult
    func clearTime() -> Bool {
         return saveTime(model: getDefaultElapsedTimeModel())
    }
    
    private func getDefaultElapsedTimeModel() -> ElapsedTimeModel{
        return ElapsedTimeModel(startTime: -1, maxTime: -1)
    }
    
    /**
     random models
     */
    func removeAlldData() -> Bool {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        return  UserDefaults.standard.synchronize()
    }

    

    
}
