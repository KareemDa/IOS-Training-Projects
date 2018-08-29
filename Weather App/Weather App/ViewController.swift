//
//  ViewController.swift
//  Weather App
//
//  Created by khalil on 8/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DateLabel: UILabel?
    @IBOutlet weak var CityLabel: UILabel?
    @IBOutlet weak var TempLabel: UILabel?
    @IBOutlet weak var MinMaxTempLabel: UILabel?
    @IBOutlet weak var ImageView: UIImageView!
    var RawData = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        DisappearAll()
        ShowAllLabels()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DisappearAll() {
        DateLabel?.alpha = 0
        CityLabel?.alpha = 0
        TempLabel?.alpha = 0
        MinMaxTempLabel?.alpha = 0
    }
    override func viewDidAppear(_ animated: Bool) {
        DisappearAll()
        view.SetGradient3Background(colorOne: Colors.sunny1, colorTwo: Colors.sunny2,colorThree: Colors.sunny3)
        ShowAllLabels()
    }
    
    
    func ShowAllLabels() {
        ShowDate()
    }
    func ShowDate() {
        UIView.animate(withDuration: 1, animations: {
            self.DateLabel?.alpha = 1
        }, completion: { (true) in
            self.ShowCity()
        })
    }
    func ShowCity() {
        UIView.animate(withDuration: 1, animations: {
            self.CityLabel?.alpha = 1
        }) { (true) in
            self.ShowTemp()
        }
    }
    
    func ShowTemp() {
        UIView.animate(withDuration: 1, animations: {
            self.TempLabel?.alpha = 1
            self.MinMaxTempLabel?.alpha = 1
        })
    }


}

