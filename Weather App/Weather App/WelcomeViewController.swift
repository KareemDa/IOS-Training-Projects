//
//  WelcomeViewController.swift
//  Weather App
//
//  Created by khalil on 8/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

// 1- make the API call based on URL and store the incoming date
    // format the URL correctly
    // send out request for the data
    // Retrieve incoming data and store it or print an error message
// 2- Parse the retrieved data ans store the correct valuews
    //  Get current Date
    // separate and store the data ento separate structs
// 3- Manipulate data into the correct formats
    // Determine the values we want
    // store values into objects(might need separate class for this)
// 4- Displaying the data in the correct label
// 5- Display Icon

import UIKit

class WelcomeViewController: UIViewController {
    
    var rawData : Data?
    var DataToView : WeatherDataHandler!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var TextFieldOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.BGColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func EndEditingAction(_ sender: UITextField) {
        
    }
    
    
    @IBAction func SegueAction(_ sender: UIButton) {
        guard let CityName = TextFieldOutlet.text else {
            return
        }
        
        let BaseURLString = "http://api.openweathermap.org/data/2.5/forecast?q="
        let KEYString = "&appid=1f6ec271f3da959c1db1575514f66264"
        
        if let FinalURL = URL(string: BaseURLString + CityName + KEYString) {
            print(FinalURL)
            RequestWeatherData(url: FinalURL)
            if let datat = rawData {
                DataToView = WeatherDataHandler(_data: datat)
                 print(DataToView.CityInfo!)
            }
            
           
        } else {
            print("Melformed URL")
        }
    }
        
        
        func RequestWeatherData(url : URL) {
            let task = URLSession.shared.dataTask(with: url) {
                (data,_,error) in
                print("teeeesdt")
                if let errorRespond = error {
                    print(errorRespond)
                    self.ErrorLabel.text = "Please enter valid city"
                }
                if let dataResponds = data {
                    print(dataResponds)
                    print("Data Responded Successfully")
                    // here im trying to send the data to the second VC.. 
                    let delay = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                        self.rawData = dataResponds
                        self.DataToView = WeatherDataHandler(_data: dataResponds)
                        let MainVC = ViewController()
                        let MaxTempString = String(describing: self.DataToView.TodayData?.MaxTemp)
                        let MinTempString = String(describing: self.DataToView.TodayData?.MinTemp)
                        let TempString = String(describing: self.DataToView.TodayData?.temp)
                        MainVC.CityLabel?.text = self.DataToView.CityInfo
                        MainVC.TempLabel?.text = TempString
                        MainVC.MinMaxTempLabel?.text = MaxTempString + "/" + MinTempString
                        MainVC.DateLabel?.text = self.DataToView.TodayData?.date
                    })
                    
                }
            }
            task.resume()
            
        }
        
    }
   

