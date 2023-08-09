//
//  ActivitiesModel.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 09.08.2023.
//

import Foundation


struct ActivitiesModel: Codable{
    let disposableActivities: [String]
    let generalActivities: [String]
    let freeTimeActivities: [String]
    
    init(disposableActivities: [String], generalActivities: [String], freeTimeActivities: [String]) {
        self.disposableActivities = disposableActivities
        self.generalActivities = generalActivities
        self.freeTimeActivities = freeTimeActivities
    }
    
    init(){
        self.disposableActivities = []
        self.generalActivities = []
        self.freeTimeActivities = []
    }
}

extension ActivitiesModel{
    public static func empty() -> ActivitiesModel{
        return ActivitiesModel()
    }
}
