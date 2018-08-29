//
//  ViewController.swift
//  RGB HEX Converter
//
//  Created by khalil on 7/29/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var RedIndex: UITextField!
    @IBOutlet weak var GreenIndex: UITextField!
    @IBOutlet weak var BlueIndex: UITextField!
    @IBOutlet weak var AlphaIndex: UITextField!
    @IBOutlet weak var ConvertionUI: UIButton!
    @IBOutlet weak var Result: UILabel!
    
    enum ConvertionType {
        case RGBtoHEX
        case HEXtoRGB
    }
    var convertion : ConvertionType = .HEXtoRGB
    var red,green,blue,alpha : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Convertion(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            convertion = .HEXtoRGB
            ConvertionUI.setTitle("Convert HEX To RGB", for: .normal)
        } else {
            convertion = .RGBtoHEX
            ConvertionUI.setTitle("Convert RGB To HEX", for: .normal)
        }
        print(convertion)
        RedIndex.text?.removeAll()
        GreenIndex.text?.removeAll()
        BlueIndex.text?.removeAll()
        AlphaIndex.text?.removeAll()
    }

    @IBAction func ConvertButton(_ sender: UIButton) {
        
        
        switch convertion {
        case .HEXtoRGB:
            self.view.backgroundColor = ConvertHEXtoRGB()
        case .RGBtoHEX:
            self.view.backgroundColor = ConvertRGBtoHEX()
        }
    
    }
    
    
    func ConvertHEXtoRGB() -> UIColor?{
        var BackgroundColor = self.view.backgroundColor
        guard let red = UInt8 (RedIndex.text! , radix: 16) else {
            Result.text = "Invalid"
            return BackgroundColor}
        guard let green = UInt8 (GreenIndex.text!, radix: 16) else {
            Result.text = "Invalid"
            return BackgroundColor}
        guard let blue = UInt8 (BlueIndex.text!, radix: 16) else {
            Result.text = "Invalid"
            return BackgroundColor}
        guard let alpha = Float(AlphaIndex.text!) else {
            Result.text = "Invalid"
            return BackgroundColor}
        if alpha > 1 || alpha < 0 { Result.text = "Invalid"
            return BackgroundColor}
        BackgroundColor = UIColor(displayP3Red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        Result.text = "Red: \(red)\nGreen: \(green)\nBlue: \(blue)\nAlpha: \(alpha)"
        return BackgroundColor
        
    }
    func ConvertRGBtoHEX() -> UIColor? {
        var BackgroundColor = self.view.backgroundColor

        guard let red = UInt8 (RedIndex.text!) else {
            Result.text = "Invalid"
            return BackgroundColor}
        guard let green = UInt8 (GreenIndex.text!) else {
            Result.text = "Invalid"
            return BackgroundColor}
        guard let blue = UInt8 (BlueIndex.text!) else {
            Result.text = "Invalid"
            return BackgroundColor}
        guard let alpha = Float(AlphaIndex.text!) else {
            Result.text = "Invalid"
            return BackgroundColor}
        if alpha > 1 || alpha < 0 { Result.text = "Invalid"
            return BackgroundColor}
        let redS = String(format: "%2X",red)
        let greenS = String(format: "%2X",green)
        let blueS = String(format: "%2X",blue)
        BackgroundColor = UIColor(displayP3Red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        
        Result.text = "HEX Code: #\(redS)\(greenS)\(blueS)\nAlpha: \(alpha)"
        
        return BackgroundColor
    }
}

