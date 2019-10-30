//
//  HeartControll.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 30/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class HeartControll: UIControl {
   
    @IBOutlet weak var likeCount: UILabel!
    
    public var likeValue: Bool = false
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1    // Количество нажатий, необходимое для распознавания
        recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
        return recognizer
    }()
    
    @objc func onTap() {
        likeValue = !likeValue
        setNeedsDisplay()
        guard let oldLikeCount = Int(likeCount.text!) else {return}
        var newLikeValue: Int = 0
        if likeValue {
            newLikeValue = oldLikeCount + 1
        } else {
            newLikeValue = oldLikeCount - 1
        }
        UIView.transition(with: likeCount, duration: 0.5, options: .transitionFlipFromTop, animations: {
            self.likeCount.text = String(newLikeValue)
        })
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(UIColor.red.cgColor)
        let heartPath = UIBezierPath()
        
        heartPath.move(to: CGPoint(x: 15, y: 30))
        heartPath.addCurve(to: CGPoint(x: 15, y: 10), controlPoint1: CGPoint(x: 27, y: 25), controlPoint2: CGPoint(x: 31, y: -9))
        heartPath.addCurve(to: CGPoint(x: 15, y: 30), controlPoint1: CGPoint(x: -2, y: -4), controlPoint2: CGPoint(x: 0, y: 13))
        heartPath.close()
        if likeValue {
            heartPath.fill()
        }
        heartPath.stroke()
    }
    
    
}
