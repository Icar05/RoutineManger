//
//  TaskCell.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

class TaskCell: UITableViewCell, RoutineCell {
   
    
    
    private var onDone: ((String) -> Void)? = nil
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var taskCheckedImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.taskCheckedImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func update(with model: RoutineModel) {
        guard let m = model as? TaskCellModel else {
            return
        }
        
        self.taskLabel.text = m.title
        self.onDone = m.onDone
    }
    
    
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil){
        self.onDone?(taskLabel.text ?? "")
    }
    
}
