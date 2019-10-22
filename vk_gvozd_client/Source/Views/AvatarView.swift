//
//  AvatarView.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 23/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowRadius: CGFloat = 0.5
    @IBInspectable var shadowOpaciti: Float = 1.0
    @IBInspectable var showBorder: Bool = true
    @IBInspectable var image: UIImage = UIImage.empty {
        didSet {
            setupView()
        }
    }
    
    private let shadowView = UIView()
    private let imageView = UIImageView()
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap))
        return recognizer
    }()
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addGestureRecognizer(tapRecognizer)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        shadowView.removeFromSuperview()
        imageView .removeFromSuperview()
        
        shadowView.layer.backgroundColor = UIColor.white.cgColor
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowOpacity = shadowOpaciti
        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
        shadowView.layer.masksToBounds = false
        addSubview(shadowView)
        
        imageView.image = image
        
        imageView.layer.masksToBounds = true
        if showBorder {
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.darkGray.cgColor
        }
        addSubview(imageView)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.frame = self.bounds
        imageView.frame = self.bounds
        shadowView.layer.cornerRadius = shadowView.bounds.width / 2
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        
    }
     
    @objc func onTap() {
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 50, options: .curveEaseInOut, animations: {
            self.imageView.bounds.size = CGSize(width: self.imageView.bounds.width * 1.2, height: self.imageView.bounds.height * 1.2)
            self.shadowView.bounds.size = CGSize(width: self.shadowView.bounds.width * 1.2, height: self.shadowView.bounds.height * 1.2)
        })
    }
}

extension UIImage {
    static var empty: UIImage {
        return UIGraphicsImageRenderer(size: CGSize.zero).image {_ in }
    }
}
