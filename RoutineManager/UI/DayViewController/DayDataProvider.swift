//
//  DayDataProvider.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import Foundation

class DayDataProvider{
    

    public func getActivitiesModel() -> ActivitiesModel{
        return parseJson()
    }
    
    private func parseJson() -> ActivitiesModel{
        if let path = Bundle.main.path(forResource: "Test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return try JSONDecoder().decode(ActivitiesModel.self, from: data)
            } catch {
                print("error: \(error)")
            }
        }
        
        return ActivitiesModel.empty()
    }

    
}
