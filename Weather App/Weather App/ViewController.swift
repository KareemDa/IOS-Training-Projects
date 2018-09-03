//
//  ViewController.swift
//  Weather App
//
//  Created by khalil on 8/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var TodayLabel: UIButton!
    
    @IBOutlet weak var TomorrowLabel: UIButton!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var MinMaxTempLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    var DataToView : WeatherDataHandler?
    enum Day {
        case today
        case tomorrow
    }
    enum Speed {
        case NoSpeed
        case Slow
        case Fast
    }
    var ShowDay : Day = .today
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
        DisappearAll(speed: .NoSpeed)
        let defaultCity = UserDefaults.standard.string(forKey: "City")
        if defaultCity != "" {
            GetCityNameAndSendGetData(textString: defaultCity)
        } else {
            SearchBar.placeholder = "Enter your city here"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Start of UISearchBarFunctions
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endSearch(searchBar: searchBar)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar : UISearchBar) {
        ShowDay = .today
        GetCityNameAndSendGetData(textString: searchBar.text)
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar : UISearchBar) {
        searchBar.placeholder = ShowCityHolder()
        searchBar.showsCancelButton =
        true
    }
    
    func endSearch(searchBar : UISearchBar) {
        searchBar.placeholder = ShowCityHolder()
        searchBar.endEditing(true)
        searchBar.text = nil
    }//End of UISearchBarFunctions

    @IBAction func ChangeDayButton(_ sender: UIButton) {
        ShowDay = sender.restorationIdentifier == "Tod" ? .today : .tomorrow
        TodayLabel.tintColor = ShowDay == .today ? UIColor.white : UIColor.gray
        TomorrowLabel.tintColor = ShowDay == .tomorrow ? UIColor.white : UIColor.gray
        ShowView(SelectedSpeed: Speed.Fast)
        
        
    }
    
    
    func SetDefaultCity() -> Bool {
        if  DataToView?.CityInfo != nil {
            return true
        }else {
            CityLabel.text = "Invalid City"
            return false
        }
    }
    
    
    
    func ShowCityHolder() -> String {
        let defaultCity = UserDefaults.standard.string(forKey: "City")
        return defaultCity == "" ? "Enter city here" : defaultCity!
    }
    
    func GetCityNameAndSendGetData(textString : String?) {
        guard let CityName = textString else {
            return
        }
        
        let BaseURLString = "http://api.openweathermap.org/data/2.5/forecast?q="
        let KEYString = "&units=metric&appid=1f6ec271f3da959c1db1575514f66264"
        
        if let FinalURL = URL(string: BaseURLString + CityName + KEYString) {
            print(FinalURL)
            RequestWeatherData(url: FinalURL,cityName: CityName) {
                //this excute after handling the callback
                success in
                DispatchQueue.main.async {
                    self.ShowView(SelectedSpeed: .Slow)
                }
            }
        } else {
            print("Melformed URL")
        }
    }
    
    
    //Send API .. RecieveJSONData..FetchItToObject and save that object
    func RequestWeatherData(url : URL,cityName: String, completion : @escaping (Bool) -> Void)  {
        let task = URLSession.shared.dataTask(with: url) {
            (data,_,error) in
            if let errorRespond = error {
                print(errorRespond)
            }
            if let dataResponds = data {
                print(dataResponds)
                print("Data Responded Successfully")
                self.DataToView = WeatherDataHandler(_data: dataResponds)
                let success = (error == nil)
                if let _ = self.DataToView?.CityInfo {
                    UserDefaults.standard.set(cityName, forKey: "City") //saveCity
                }
                
                completion(success)
            }
        }
        task.resume()
    }
    
    
    func ShowView(SelectedSpeed : Speed) {
        DisappearAll(speed: SelectedSpeed)
        if ValidData() {
            AssignToLabels()
            ShowAllLabels(speed: SelectedSpeed)
        }
        else {
            DisplayCityError()
        }
    }
    func DisplayCityError() {
        ImageView.image = UIImage(named: "sadCloud")
        CityLabel.text = "Please Enter Valid City"
        UIView.animate(withDuration: 0.5, animations: {
            self.CityLabel.alpha = 1
            self.ImageView.alpha = 1
        })
    }
    
    func ValidData() -> Bool {
        return ((DataToView?.CityInfo) != nil)
    }
    
    func AssignToLabels() {
        CityLabel.text = DataToView?.CityInfo
        let data = ShowDay == .today ? DataToView?.TodayData : DataToView?.TomorrowData
        DateLabel.text = data?.date
        TempLabel.text = String(describing: Int((data?.avgTemp)!))
        MinMaxTempLabel.text = String(describing: Int((data?.maxTemp)!)) + "/" + String(describing: Int((data?.minTemp)!))
        ImageView.image = UIImage(named: (data?.icon)!)
        view.backgroundColor = UIColor.black
        view.SetBackGroundColor(icon: (data?.icon)!)   
    }
    
    func SetAlphaTo(_ number: CGFloat) {
        DateLabel.alpha = number
        CityLabel.alpha = number
        TempLabel.alpha = number
        ImageView.alpha = number
        MinMaxTempLabel.alpha = number
    }
    
    
    func DisappearAll(speed: Speed) {
        switch speed {
        case .NoSpeed :
            SetAlphaTo(0)
        case .Fast:
            UIView.animate(withDuration: 0.3, animations: {
                self.SetAlphaTo(0)
            })
        default:
            SetAlphaTo(0)
        }
    }
    
    func ShowAllLabels(speed: Speed) {
        switch speed {
        case .NoSpeed:
            SetAlphaTo(1)
        case .Fast:
            UIView.animate(withDuration: 0.3, animations: {
                self.SetAlphaTo(1)
            })
        case .Slow:
            ShowCity()
        }
    }
    
    func ShowCity() {
        UIView.animate(withDuration: 1, animations: {
            self.CityLabel.alpha = 1
            self.DateLabel.alpha = 1
            self.ImageView.alpha = 1
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

