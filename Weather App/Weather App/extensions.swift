//
//  Extensions.swift
//  Weather App
//
//  Created by khalil on 9/1/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIButton {
    func appearSearchLabel() {
        self.setImage(nil, for: .normal)
        self.transform = CGAffineTransform(scaleX: 30, y: 30)
        self.backgroundColor = UIColor.white
        self.alpha = 0.7
    }
    
    func disappearSearchLabel() {
        self.setImage(UIImage(named: "searchh-box"),for: UIControlState.normal)
        self.transform = CGAffineTransform(scaleX: 1, y: 1)
        self.backgroundColor = UIColor.clear
        self.alpha = 1
    }
}

