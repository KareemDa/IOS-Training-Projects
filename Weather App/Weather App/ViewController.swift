//
//  ViewController.swift
//  Weather App
//
//  Created by khalil on 8/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var MinMaxTempLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    var DataToView : WeatherDataHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DisappearAll() {
        DateLabel.alpha = 0
        CityLabel.alpha = 0
        TempLabel.alpha = 0
        MinMaxTempLabel?.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.SetGradient3Background(colorOne: Colors.sunny1, colorTwo: Colors.sunny2,colorThree: Colors.sunny3)
        DisappearAll()
        ShowAllLabels()
    }
    
    
    func ShowAllLabels() {
        AssignToLabels()
        ShowCity()
    }
    
    func AssignToLabels() {
        CityLabel.text = DataToView?.CityInfo
        DateLabel.text = DataToView?.TodayData?.date
        TempLabel.text = String(describing: Int((DataToView?.TodayData?.avgTemp)!))
        MinMaxTempLabel.text = String(describing: Int((DataToView?.TodayData?.maxTemp)!)) + "/" + String(describing: Int((DataToView?.TodayData?.minTemp)!))
    }
    
    func ShowCity() {
        UIView.animate(withDuration: 1, animations: {
            self.CityLabel.alpha = 1
            self.DateLabel.alpha = 1
        }) { (true) in
            self.ShowTemp()
        }
    }
    
    func ShowTemp() {
        UIView.animate(withDuration: 1, animations: {
            self.TempLabel.alpha = 1
            self.MinMaxTempLabel.alpha = 1
        })
    }
    
    func ShowDate() {
        UIView.animate(withDuration: 1, animations: {
            self.CityLabel.alpha = 1
        }, completion: { (true) in
            self.ShowTemp()
            
        })
    }

}

