//
//  HeaderCellModel.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

 
struct HeaderCellModel: RoutineModel{
    
    func isHeader() -> Bool {
        true
    }
    
    func getGroup() -> Int {
        return group
    }
    
    
    func getTitle() -> String {
        return title
    }
    
    let group: Int
    let title: String
    let color: UIColor
    let titleColor: UIColor
        
    var reuseIdentifier: String = String(describing: Headercell.self)

}
