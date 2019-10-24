//
//  TestViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 13/10/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//
	
import UIKit

class TestViewController: UIViewController{
    
    @IBOutlet weak var aniView: UIView!
    @IBOutlet var constraint: NSLayoutConstraint!
    @IBOutlet weak var textFiled: UITextField!
    
//    @IBAction func textTouch(_ sender: UITextField) {
//        textFiled.text = "ХЕРАСЕ"
//    }
    @IBAction func textFieldEditingDidBegin(_ sender: UITextField) {
        textFiled.text = "ХЕРАСЕ"
    }
    
    
    
    @IBAction func animation1(sender: UIButton) {
        UIView.animate(withDuration: 3) {
            self.aniView.frame.origin.y -= 200
            self.aniView.frame.origin.x += 50
        }
    }
    
    @IBAction func animation2(sender: UIButton) {
        UIView.animate(withDuration: 1.5) {
            self.aniView.frame.origin.y -= 150
        }
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            self.aniView.frame.origin.y += 150
            
        })
        
    }
    
    @IBAction func animation3(sender: UIButton) {
        UIView.animate(withDuration: 1.5, animations: {
            self.aniView.alpha = 0.2
        }) { comleted in
            UIView.animate(withDuration: 1.5, animations: {
                self.aniView.alpha = 1
            })
        }
    }
    
    @IBAction func animation4(sender: UIButton) {
        constraint.isActive.toggle()
        UIView.animate(withDuration: 1.5, animations: view.layoutIfNeeded)
    }
    
    @IBAction func animation5(sender: UIButton) {
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.aniView.frame.origin.y -= 300
        })
    }
    
    @IBAction func animation6(sender: UIButton) {
        UIView.transition(with: aniView, duration: 0.3, options: [.transitionCrossDissolve, .autoreverse, .repeat], animations: {
            self.aniView.backgroundColor = UIColor.black
        })
    }
    
    @IBAction func animation7(sender: UIButton) {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 1
        animation.toValue = 0.1
        animation.duration = 2
//        animation.repeatCount = 3
//        animation.autoreverses = true
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        aniView.layer.add(animation, forKey: nil)
        
    }
    
    @IBAction func animation8(sender: UIButton) {
    }
    
    @IBAction func animation9(sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 30, options: .curveEaseInOut, animations: {
            self.aniView.frame.origin.y -= 75
        })
    }
    
    @IBAction func animation10(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    



}
