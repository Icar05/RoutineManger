//
//  TimerView.swift
//  RS
//
//  Created by ICoon on 27.07.2022.
//

import UIKit

enum TimerState{
    case STARTED, FINISHED, CLEAR
}

public protocol TimerViewDelegate: NSObject{
    func didStartTimerClick()
    func didStopTimerClick()
    func didRefreshClick()
    func onButtonDidTap()
}


let TIMER_COLOR = UIColor.black

@IBDesignable
class TimerView: UIView {
    
    
    
    
    private var displayView: TimerDisplay = getDisplay()
    
    private var sizeOfView: CGFloat = 250
    
    private var clockLabel: UILabel = UILabel()
    
    private var actonLabel: UILabel = UILabel()
    
    private var elapsedLabel: UILabel = UILabel()
    
    private var state: TimerState = .CLEAR
    
    private let outColor: UIColor = TIMER_COLOR
    
    public var buttonCallback: (() -> Void )?
    
    weak var delegate: TimerViewDelegate? = nil
    

    
    override func prepareForInterfaceBuilder(){
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    override var bounds: CGRect {
        didSet {
            self.frame = CGRect(x: 0, y: 0, width: sizeOfView, height: sizeOfView)
            self.displayView.center = self.center
            self.clockLabel.center = self.center
            self.setActionLabelPosition()
            self.setEllaptionLabelPosition()
        }
    }
    
    func restoreState(model: TimerUtilState){
        switch model.state{
            case .STARTED:
                onTimerStart()
            case .FINISHED:
                onTimerFinished(maxValue: model.maxTime.toSeconds())
            case .CLEAR:
                onTimerStop(maxValue: model.maxTime.toSeconds())
        }
    }
    
    func setDisplayColorPrefs(color: Color, singleColor: Bool){
        self.displayView.updateProgressColor(color: color.uiColor)
        self.displayView.setSingleUpdaterColor(value: singleColor)
    }
    
    func onTimerStart(){
        self.state = .STARTED
        self.handleState()
    }
    
    func onTimerStop(maxValue: Int) {
        self.state = .CLEAR
        self.handleState()
        self.updateClocklabel(value: maxValue)
        self.displayView.updateCurrentValue(current: maxValue, max: maxValue)
    }
    
    func onTimerFinished(maxValue: Int) {
        self.state = .FINISHED
        self.handleState()
        self.updateClocklabel(value: 0)
        self.displayView.updateCurrentValue(current: 0, max: maxValue)
    }
    
    func onTimerUpdate(current: Int, max: Int) {
        self.updateClocklabel(value: current)
        self.displayView.updateCurrentValue(current: current, max: max)
    }
    
    
    
    fileprivate func setup(){
        
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(displayView)
        self.addSubview(clockLabel)
        self.addSubview(actonLabel)
        self.addSubview(elapsedLabel)
        
        self.setupClockLabel()
        self.setupActionLabel()
        self.setupElapsedLabel()
        
        self.handleState()
    }
    
    func updateElapsedLabel(value: String){
        self.elapsedLabel.text = value
    }
    
    fileprivate func setupElapsedLabel(){
        let fontSize = sizeOfView / 12
        let actionWidth = sizeOfView / 1.5
        let actionHeight = sizeOfView /  getLabelHeightMultyPlyer()
        
        self.elapsedLabel.textColor = UIColor.red
        self.elapsedLabel.frame =  CGRect(x: 0, y: 0, width: actionWidth, height: actionHeight)
        self.elapsedLabel.textAlignment = .center
        self.elapsedLabel.font = UIFont(name: elapsedLabel.font.familyName, size: fontSize)
    }
    
    fileprivate func setupActionLabel(){
        let fontSize = sizeOfView / getFontMultyPlyer()
        let actionWidth = sizeOfView / 1.5
        let actionHeight = sizeOfView / getLabelHeightMultyPlyer()
        
        self.actonLabel.frame =  CGRect(x: 0, y: 0, width: actionWidth, height: actionHeight)
        self.actonLabel.textAlignment = .center
        self.actonLabel.font = UIFont(name: actonLabel.font.familyName, size: fontSize)
        self.actonLabel.isUserInteractionEnabled = true
        self.actonLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
    }
    
    
    
    fileprivate func setupClockLabel(){
        let fontSize = sizeOfView / 6
        let clockWidth = sizeOfView / 1.5
        let clockHeight = sizeOfView / 5
        
        self.clockLabel.frame =  CGRect(x: 0, y: 0, width: clockWidth, height: clockHeight)
        self.clockLabel.textAlignment = .center
        self.clockLabel.textColor = outColor
        self.clockLabel.font = UIFont(name: "DBLCDTempBlack", size: fontSize)
        self.updateClocklabel(value: 0)
    }
    
    fileprivate func setActionLabelPosition(){
        let marginBottom = self.sizeOfView / 4
        self.actonLabel.center.x = self.center.x
        self.actonLabel.center.y = self.frame.size.height - marginBottom
    }
    
    fileprivate func setEllaptionLabelPosition(){
        self.elapsedLabel.center.x = self.center.x
        self.elapsedLabel.center.y = self.sizeOfView / 4
    }
    
    fileprivate func updateClocklabel(value: Int){
        let time: (Int, Int) = secondsToHoursMinutesSeconds(value)
        let minutes = numToString(value: time.0)
        let seconds = numToString(value: time.1)
        self.clockLabel.text = "\(minutes):\(seconds)"
    }
    
    
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil){
        self.delegate?.onButtonDidTap()
        self.buttonCallback?()
    }
    
    private func handleState(){
        switch self.state {
        case .STARTED:
            self.actonLabel.attributedText = getActionTextAttributes(
                text: "STOP"
            )
            self.buttonCallback = {
                self.delegate?.didStopTimerClick()
            }
            
            return
        case .FINISHED:
            self.actonLabel.attributedText = getActionTextAttributes(
                text: "REFRESH"
            )
            self.buttonCallback = {
                self.delegate?.didRefreshClick()
            }
            
            return
        case .CLEAR:
            self.actonLabel.attributedText = getActionTextAttributes(
                text: "START"
            )
            self.buttonCallback = {
                self.delegate?.didStartTimerClick()
            }
            return
        }
    }
    
    fileprivate func getActionTextAttributes(text: String) -> NSAttributedString{
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: outColor,
            .foregroundColor: UIColor.white,
            .strokeWidth: -5.0
        ]
        
        return NSAttributedString(string: text, attributes: strokeTextAttributes)
    }
    
    fileprivate func numToString(value: Int) -> String{
        return (value < 10) ? "0\(value)" : "\(value)"
    }
    
    fileprivate func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    fileprivate func getFontMultyPlyer() -> CGFloat{
        return  10
    }
    
    fileprivate func getLabelHeightMultyPlyer() -> CGFloat{
        return  9
    }
    
    fileprivate static func getDisplay() -> TimerDisplay{
        return  TimerDisplayView()
    }
    
   
}
