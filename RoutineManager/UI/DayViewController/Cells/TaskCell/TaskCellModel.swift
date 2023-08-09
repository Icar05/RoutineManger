//
//  TaskCellModel.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import Foundation

struct TaskCellModel: RoutineModel{
    
    
    func isHeader() -> Bool {
        return false
    }
    
    func getGroup() -> Int {
        return group
    }
    
    func getTitle() -> String {
        return title
    }
    
    let group: Int
    let title: String
    var onDone: (String) -> Void
    
    var reuseIdentifier: String = String(describing: TaskCell.self)

}
