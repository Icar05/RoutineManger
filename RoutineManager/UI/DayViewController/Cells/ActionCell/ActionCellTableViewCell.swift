//
//  ActionCellTableViewCell.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

class ActionCellTableViewCell: UITableViewCell, RoutineCell {
    
    
    
    private var onTouch: (() -> Void)? = nil
    
    @IBOutlet weak var actionLabel: UILabel!
    
    @IBOutlet weak var actionContainer: UIView!
    
    @IBOutlet weak var actionBackground: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.actionContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with model: RoutineModel) {
        guard let m = model as? ActionCellModel else {
            return
        }
        
        self.actionContainer.backgroundColor = m.backgrooundColor.withAlphaComponent(0.9)
        self.actionLabel.text = m.title
        self.actionLabel.textColor = m.textColor
        self.onTouch = m.onTouch
    }
    
    
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil){
        self.onTouch?()
    }
    
}
