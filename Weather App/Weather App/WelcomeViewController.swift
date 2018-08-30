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
    
    var DataToView : WeatherDataHandler?
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

    @IBAction func EndEditing(_ sender: UITextField) {
        guard let CityName = sender.text else {
            return
        }
        let BaseURLString = "http://api.openweathermap.org/data/2.5/forecast?q="
        let KEYString = "&units=metric&appid=1f6ec271f3da959c1db1575514f66264"
        
        if let FinalURL = URL(string: BaseURLString + CityName + KEYString) {
            print(FinalURL)
            RequestWeatherData(url: FinalURL) {
                //this excute after handling the callback
                success in
                let MainVC = (UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! ViewController) //Should define it like this not like: let MainVC = viewController()
                MainVC.DataToView = self.DataToView
                self.present(MainVC, animated: true, completion: nil)
            }
        } else {
            print("Melformed URL")
        }
        
    }
    
    //Send API .. RecieveJSONData..FetchItToObject and save that object
    func RequestWeatherData(url : URL,completion : @escaping (Bool) -> Void)  {
            let task = URLSession.shared.dataTask(with: url) {
                (data,_,error) in
                if let errorRespond = error {
                    print(errorRespond)
                    self.ErrorLabel.text = "Please enter valid city"
                }
                if let dataResponds = data {
                    print(dataResponds)
                    print("Data Responded Successfully")
                    self.DataToView = WeatherDataHandler(_data: dataResponds)
                    let success = (error == nil)
                    completion(success)
  
                }
            }
            task.resume()
            
        }
        
    }






/*let MaxTempString = String(describing: self.DataToView.TodayData?.MaxTemp)
 let MinTempString = String(describing: self.DataToView.TodayData?.MinTemp)
 let TempString = String(describing: self.DataToView.TodayData?.temp)
 MainVC.CityLabel?.text = self.DataToView.CityInfo
 MainVC.TempLabel?.text = TempString
 MainVC.MinMaxTempLabel?.text = MaxTempString + "/" + MinTempString
 MainVC.DateLabel?.text = self.DataToView.TodayData?.date*/
   

