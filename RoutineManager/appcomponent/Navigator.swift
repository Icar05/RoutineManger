//
//  Navigator.swift
//  iOSTestPlayground
//
//  Created by Галяткин Александр on 11.05.2023.
//

import UIKit

public final class Navigator{
    
    public func getTimerScreen(timerUtil: TimerUtil) -> UIViewController{
        let presenter = TimerPresenter()
        let vc = TimerViewController(presenter: presenter, timerUtil: timerUtil)
            presenter.set(view: vc)
        return vc
    }
    
    public func getInitialController() -> UIViewController{
        let navVc = InitialViewController()
        navVc.viewControllers = [getFirstScreen()]
        return navVc
    }

    
    public func getFirstScreen() -> UIViewController{
        let presenter = DayPresenter()
        let vc = DayViewController(presenter: presenter)
            presenter.set(view: vc)
        return vc
    }
    
}
