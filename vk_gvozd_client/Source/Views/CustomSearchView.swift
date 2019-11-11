//
//  CustomSearchView.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 24.10.2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class CustomSearchView: UIView {
    @IBOutlet weak var searchImageRightConstrain: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonWight: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func cancelButtonAction(sender: UIButton) {
        cancelAnimation()
    }
    
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap))
        return recognizer
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addGestureRecognizer(tapRecognizer)
    }
    
    private func cancelAnimation() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.searchImageRightConstrain.constant = 0
            self.layoutIfNeeded()
        })
        
        UIView.animate(withDuration: 0.5) {
            self.cancelButtonWight.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    @objc func onTap() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.searchImageRightConstrain.constant = self.frame.width * 0.85
            self.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.5) {
            self.cancelButtonWight.constant = 60
            self.layoutIfNeeded()
        }
        self.searchTextField.becomeFirstResponder()
    }
}
