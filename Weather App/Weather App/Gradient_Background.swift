//
//  Gradient_Background.swift
//  Weather App
//
//  Created by khalil on 8/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func SetGradientBackground(colorOne: UIColor,colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor,colorTwo.cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y:1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0,y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    func SetGradient3Background(colorOne: UIColor,colorTwo: UIColor,colorThree: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor,colorTwo.cgColor,colorThree.cgColor]
        gradientLayer.locations = [0.0,0.5,1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y:1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0,y: 0.1)        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
