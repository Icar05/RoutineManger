//
//  TimerDisplayLayerView.swift
//  RS
//
//  Created by ICoon on 30.07.2022.
//

import UIKit


/**
 thanks to https://cemkazim.medium.com/how-to-create-animated-circular-progress-bar-in-swift-f86c4d22f74b
 */
@IBDesignable
class TimerDisplayView: UIView, TimerDisplay {
    
    
    
    
    private var circleColor = UIColor.black
        
    private var progressColor = TIMER_COLOR
    
    private let lineWidth = 8.0
    
    private var circleLayer = CAShapeLayer()
    
    private var progressLayer = CAShapeLayer()
    
    private var startPoint = CGFloat(-Double.pi / 2)
    
    private var endPoint = CGFloat(3 * Double.pi / 2)
    
    private var sizeOfView: CGFloat = 250
    
    private var singleUpdateColor: Bool = false
    
    
    
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
        }
    }
    
    
    fileprivate func setup(){
        self.layer.bounds.size = CGSize(width: CGFloat(sizeOfView), height: CGFloat(sizeOfView))
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clear
        self.createCircularPath()
    }
    
    func createCircularPath() {
        let path = getPath()
        self.setupLayer(currentLayer: circleLayer, path: path, color: circleColor, strokeEnd: 1.0)
        self.setupLayer(currentLayer: progressLayer, path: path, color: progressColor, strokeEnd: 0)
    }
    
    func setSingleUpdaterColor(value: Bool) {
        self.singleUpdateColor = value
    }
    
    func updateCurrentValue(current: Int, max: Int) {
        let elapsed = max - current
        let percent: Double = Double((elapsed * 100 ) / max)
        progressLayer.strokeEnd = percent * 0.01
    }
    
    func updateProgressColor(color: UIColor) {
        self.progressColor = color
        self.progressLayer.strokeColor = color.cgColor
    }
    
    
    private func getPath() -> UIBezierPath{
        let radius = (self.sizeOfView / 2) - 10
        let arcCenter = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)
        return UIBezierPath(arcCenter: arcCenter, radius: radius,
                            startAngle: startPoint, endAngle: endPoint, clockwise: true)
    }
    
    private func setupLayer(currentLayer: CAShapeLayer, path: UIBezierPath, color: UIColor, strokeEnd: Double){
        currentLayer.path = path.cgPath
        currentLayer.fillColor = UIColor.clear.cgColor
        currentLayer.lineCap = .round
        currentLayer.lineWidth = lineWidth
        currentLayer.strokeEnd = strokeEnd
        currentLayer.strokeColor = color.cgColor
        
        layer.addSublayer(currentLayer)
    }
}
