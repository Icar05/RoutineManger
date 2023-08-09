//
//  ActionCellModel.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

struct ActionCellModel: RoutineModel{
    
    func isHeader() -> Bool {
        false
    }
    
    func getGroup() -> Int {
        return group
    }
    
    
    func getTitle() -> String {
        return title
    }
    
    let group: Int
    let title: String
    let backgrooundColor: UIColor
    let textColor: UIColor
    var onTouch: () -> Void
    
    var reuseIdentifier: String = String(describing: ActionCellTableViewCell.self)

}
