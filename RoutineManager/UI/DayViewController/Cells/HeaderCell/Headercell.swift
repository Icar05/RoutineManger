//
//  Headercell.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

final class Headercell: UITableViewCell, RoutineCell {
    
    
    
    
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var container: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func update(with model: RoutineModel) {
        
        guard let m = model as? HeaderCellModel else {
            return
        }
        
        
        self.container.backgroundColor = m.color.withAlphaComponent(0.8)
        self.headerLabel.text = m.title
        self.headerLabel.textColor = m.titleColor
    }
}



