//
//  TimerViewController.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

public final class TimerViewController: UIViewController {
    
    
    
    private var soundUtil: SoundUtil? = nil
    
    private unowned var timerUtil: TimerUtil
    
    private let presenter: TimerPresenter
    
    private var autoRelaunch = true
    
    @IBOutlet weak var timerView: TimerView!
    
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: TimerPresenter, timerUtil: TimerUtil) {
        self.presenter = presenter
        self.timerUtil = timerUtil
        super.init(nibName: "TimerViewController", bundle: Bundle.main)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavbar(title: "Таймер")
        self.presenter.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.timerView.delegate = self
        self.timerUtil.delegate = self
    }
    
    public func setupTimer(){
        self.timerView.setDisplayColorPrefs(color: Color.init(uiColor: UIColor.appGreen()), singleColor: true)
        self.timerView.restoreState(model: timerUtil.getState())
    }
    
}

extension TimerViewController: TimerViewDelegate{
    
    
    public func didStartTimerClick() {
        self.timerUtil.startTimer()
    }
    
    public func didStopTimerClick() {
        self.timerUtil.stopTimer()
    }
    
    public func didRefreshClick() {
        self.timerUtil.stopSound()
        self.autoRelaunch ? timerUtil.startTimer() : timerUtil.refreshTimer()
    }
    
    public func onButtonDidTap() {
        self.soundUtil = SoundUtil( sound: .RecorderClick)
        self.soundUtil?.play()
    }
    
}


extension TimerViewController: TimerUtilDelegate{
    
    
    public func onTimerStart() {
        self.timerView.onTimerStart()
    }
    
    public func onTimerStop(maxValue: Int) {
        self.timerView.onTimerStop(maxValue: maxValue)
    }
    
    public func onTimerFinished(maxValue: Int) {
        self.timerView.onTimerFinished(maxValue: maxValue)
    }
    
    public func onTimerUpdate(current: Int, max: Int) {
        self.timerView.onTimerUpdate(current: current, max: max)
    }
    
    public func needDebug(value: String) {
        self.timerView.updateElapsedLabel(value: value)
    }
    
}

