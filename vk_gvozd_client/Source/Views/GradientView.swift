//
//  GradientView.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 23/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    @IBInspectable var radius: CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.layer.borderWidth = 3
//        self.layer.borderColor = UIColor.red.cgColor
//        self.layer.cornerRadius = 10
//        self.layer.masksToBounds = true
//
//        self.layer.shadowRadius = 12
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = .zero
//        self.layer.shadowOpacity = 0.4

//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.black.cgColor,UIColor.green.cgColor]
//        gradientLayer.locations = [0 as NSNumber, 1 as NSNumber]
//        gradientLayer.startPoint = CGPoint.zero
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        gradientLayer.frame = self.bounds
//
//        self.layer.addSublayer(gradientLayer)
        
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
//        self.layer.borderWidth = 3
//        self.layer.borderColor = UIColor.red.cgColor
//        self.layer.cornerRadius = 16
//        self.layer.masksToBounds = true
//
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowRadius = 8
//        self.layer.shadowOffset = .zero
        
//        self.backgroundColor = .red
//        let maskLayer = CAShapeLayer()
//        let starPath = UIBezierPath()
//        starPath.move(to: CGPoint(x: 40, y: 20))
//        starPath.addLine(to: CGPoint(x: 45, y: 40))
//        starPath.addLine(to: CGPoint(x: 65, y: 40))
//        starPath.addLine(to: CGPoint(x: 50, y: 50))
//        starPath.addLine(to: CGPoint(x: 60, y: 70))
//        starPath.addLine(to: CGPoint(x: 40, y: 55))
//        starPath.addLine(to: CGPoint(x: 20, y: 70))
//        starPath.addLine(to: CGPoint(x: 30, y: 50))
//        starPath.addLine(to: CGPoint(x: 15, y: 40))
//        starPath.addLine(to: CGPoint(x: 35, y: 40))
//        starPath.close()
//        starPath.stroke()
//        maskLayer.path = starPath.cgPath // Тот path, с помощью которого рисовали звезду
//        self.layer.mask = maskLayer
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
//        gradientLayer.locations = [0 as NSNumber, 1 as NSNumber]
//        gradientLayer.startPoint = CGPoint.zero
//        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//
//        self.layer.addSublayer(gradientLayer)
//        gradientLayer.frame = self.bounds

        
//        context.setFillColor(UIColor.red.cgColor)
//        context.fillEllipse(in: CGRect(x: 25, y: 75, width: 150, height: 50))
        
        
//        context.move(to: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
//        context.addLine(to: CGPoint(x: 25, y: 25))
//        context.addLine(to: CGPoint(x: 175, y: 25))
//        context.addLine(to: CGPoint(x: 175, y: 175))
//        context.addLine(to: CGPoint(x: 25, y: 175))
//        context.closePath()
//
//        context.setStrokeColor(UIColor.red.cgColor)
//        context.strokePath()

        
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
//        path.addLine(to: CGPoint(x: 25, y: 25))
//        path.addLine(to: CGPoint(x: 175, y: 25))
//        path.addLine(to: CGPoint(x: 175, y: 175))
//        path.addLine(to: CGPoint(x: 25, y: 175))
//        path.close()

//        path.addCurve(to: CGPoint(x: 100, y: 20), controlPoint1: CGPoint(x: 20, y: 100), controlPoint2: CGPoint(x: 100, y: 180))
//        path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: radius, startAngle: 0, endAngle: 180, clockwise: true)

//        UIColor.green.setStroke()
//        path.stroke()
        
    }
}
