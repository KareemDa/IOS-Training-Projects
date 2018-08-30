//
//  WeatherDataHandler.swift
//  Weather App
//
//  Created by khalil on 8/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import Foundation

class WeatherDataHandler {
    let data: Data
    var weatherJSONData : WeatherData?
    var CityInfo : String?
    var TodayData : WeatherDay?
    var TomorrowData: WeatherDay?
    
    init(_data: Data) {
        self.data = _data
        decoodeData()
    }
    func decoodeData() {
        let decoder = JSONDecoder()
        do {
            weatherJSONData = try decoder.decode(WeatherData.self, from: self.data)
            if let city = weatherJSONData {
                CityInfo = city.city.name + ", " + city.city.country
                PrepareTodayTomorrowData()
            }
        } catch {
            print(error)
            print("tEst")
        }
    }
    
    func PrepareTodayTomorrowData() {
        guard let weatherData = weatherJSONData else { return }
        
        var TodayTemperaturesList = [Temparetures()]
        var TomorrowTemperaturesList = [Temparetures()]
        //sorting data between today and tomorrow
         for DataPoint in weatherData.list {
            let DataPointDate = setDateToHndlerDate(Date: DataPoint.dt_txt)
            if DataPointDate == DateHandler.todaysDate {
               TodayTemperaturesList.append(Temparetures(_avg: DataPoint.main.temp, _min: DataPoint.main.temp_min, _max: DataPoint.main.temp_max))
            } else if DataPointDate == DateHandler.tomorrowsDate {
                TomorrowTemperaturesList.append(Temparetures(_avg: DataPoint.main.temp, _min: DataPoint.main.temp_min, _max: DataPoint.main.temp_max))
            }
        }
        //calculating temperatures(average - min - max)
        var TodayTemperature = Temparetures(_avg: Average(Temp: TodayTemperaturesList), _min: Minimum(Temp: TodayTemperaturesList), _max: Maximum(Temp: TodayTemperaturesList))
        var TomorrowTemperature = Temparetures(_avg: Average(Temp: TomorrowTemperaturesList), _min: Minimum(Temp: TomorrowTemperaturesList), _max: Maximum(Temp: TomorrowTemperaturesList))
        
        //converting to kelvin
       /* TodayTemperature.KelvinToCelsius()
        TomorrowTemperature.KelvinToCelsius()*/
        
        
        //assigning values to the main variables
        TodayData = WeatherDay(temperature: TodayTemperature, _date: DateHandler.todaysDate)
        TomorrowData = WeatherDay(temperature: TomorrowTemperature, _date: DateHandler.tomorrowsDate)
    }
    
    func Maximum(Temp : [Temparetures]) -> Double {
        return Temp.map{$0.max}.max()!
        
    }
    func Minimum(Temp : [Temparetures]) -> Double {
        return Temp.map{$0.min}.min()!
    }
    
    func Average(Temp : [Temparetures]) -> Double {
        return (Temp.map{$0.avg}.reduce(0,+))/Double(Temp.count - 1)
    }
    
    func setDateToHndlerDate(Date: String) -> String {
        let endIndex = Date.index(Date.startIndex, offsetBy: DateHandler.Offset)
        return String(Date[..<endIndex])
    }
    

}
