//
//  TimerDisplay.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit

protocol TimerDisplay: UIView{

    func setSingleUpdaterColor(value: Bool)
        
    func updateCurrentValue(current: Int, max: Int)
    
    func updateProgressColor(color: UIColor)
}
