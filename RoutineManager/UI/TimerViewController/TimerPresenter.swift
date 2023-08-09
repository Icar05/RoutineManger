//
//  TimerPresenter.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import Foundation

public final class TimerPresenter{
    
    
    unowned var view: TimerViewController!
    
    
    public func set(view: TimerViewController) {
        self.view = view
    }
    
    public func viewDidLoad(){
        self.view.setupTimer()
    }
    
}
