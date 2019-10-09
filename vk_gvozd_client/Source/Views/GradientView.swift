//
//  GradientView.swift
//  Weather
//
//  Created by Владислав Фролов on 19/09/2019.
//  Copyright © 2019 Владислав Фролов. All rights reserved.
//  Решение столь изящно, что не стал изобретать велосипед. удобный класс. Спасибо

import UIKit

@IBDesignable class GradientView: UIView {
    
    //MARK: - Overriding layer class in order to make it Gradient
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    //MARK: - Computed property to make layer easy accessable
    public var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    //MARK: - Class configuiring properties
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable var midColor: UIColor = .gray {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable var startLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }
    
    @IBInspectable var midLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }
    
    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
            self.updateLocations()
        }
    }
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            self.updateStartPoint()
        }
    }
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.updateEndPoint()
        }
    }
    
    //MARK: - Class configuiring methods
    private func updateLocations() {
        var locations = [self.startLocation as NSNumber,
        self.endLocation as NSNumber]
        
        if midLocation != 0 {
            locations.insert(midLocation as NSNumber, at: 1)
        }
        self.gradientLayer.locations = locations
    }
    
    private func updateColors() {
        self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
    }
    
    private func updateStartPoint() {
        self.gradientLayer.startPoint = startPoint
    }
    
    private func updateEndPoint() {
        self.gradientLayer.endPoint = endPoint
    }
}
