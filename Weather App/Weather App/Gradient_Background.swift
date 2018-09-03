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
    func SetBackGroundColor(icon : String) {
        switch icon {
        case "01d":
            self.SetGradient3Background(colorOne: Colors.sunny1, colorTwo: Colors.sunny2,colorThree: Colors.sunny3)
        case "02d":
            self.SetGradient3Background(colorOne: Colors.partCloudy1, colorTwo: Colors.partCloudy2, colorThree: Colors.partCloudy3)
        case "01n","02n":
            self.SetGradient3Background(colorOne: Colors.night1, colorTwo: Colors.night2,colorThree: Colors.night3)
        case "09d","09n","10d","10n":
            self.SetGradient3Background(colorOne: Colors.rain1, colorTwo: Colors.rain2,colorThree: Colors.rain3)
        default:
            self.SetGradient3Background(colorOne: Colors.cloudy1, colorTwo: Colors.cloudy2,colorThree: Colors.cloudy3)
        }
    }
    
    func SetGradient3Background(colorOne: UIColor,colorTwo: UIColor,colorThree: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor,colorTwo.cgColor,colorThree.cgColor]
        gradientLayer.locations = [0.0,0.5,1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y:1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: -0.1)
        guard let _ = layer.sublayers?.count else {
            layer.insertSublayer(gradientLayer, at: 0)
            return
        } // Checking if there is a previous layer to replace the old one with new one
        for layers in layer.sublayers! {
            if let thislayer = layers as? CAGradientLayer {
                layer.replaceSublayer(thislayer, with: gradientLayer)
                return
            }
        }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


