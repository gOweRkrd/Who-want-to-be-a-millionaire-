//
//  CircleTimer.swift
//  Who want to be a millionaire?
//
//  Created by Админ on 11.11.2022.
//

//Ты вообще понимаешь что такое UIKit и из чего он состоит?!
import Foundation
import UIKit

class CircleTimerShape: UIViewController  {
    
    var pulsingLayer: CAShapeLayer!
    var circleLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!
    var durationLine = 0.0
    let color1 = #colorLiteral(red: 0.07450980392, green: 0.4235294118, blue: 0.7254901961, alpha: 1)
    let color2 = #colorLiteral(red: 0.8352941176, green: 0.6705882353, blue: 0, alpha: 1)
    let color3 = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.4570478225)
    let color4 = #colorLiteral(red: 0.1497105928, green: 0.6043053612, blue: 0.7280215983, alpha: 0.6094313868)
  
    func createCircleShapeLayer(fillColor: UIColor, strokeColor: UIColor ) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 40, startAngle: 0, endAngle: 2 * CGFloat.pi , clockwise: true)
        layer.path = circularPath.cgPath
        layer.fillColor = fillColor.cgColor
        layer.lineCap = .round
        layer.lineWidth = 10.0
        layer.strokeEnd = 0.0
        layer.position = CGPoint(x:view.frame.width/2 , y:view.frame.width/3.5)
        layer.strokeColor = strokeColor.cgColor
        layer.shadowOpacity = 0.5
        return layer
    }
    
    func shapeSetting() {
        
        pulsingLayer = createCircleShapeLayer(fillColor: color3, strokeColor: .orange)
        circleLayer = createCircleShapeLayer(fillColor: color4, strokeColor: .lightGray)
        progressLayer = createCircleShapeLayer(fillColor: .clear, strokeColor: .yellow)
        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
    }
    
    func animateCircle() {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
    func animatePulsingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.2
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        pulsingLayer.add(animation, forKey: "pulsing")
    }
}
