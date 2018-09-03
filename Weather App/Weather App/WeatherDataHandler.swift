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
        
        //Getting list of todaytomorrow temperatures and icons
        let TodayTemperaturesIconList = GetTemperatureIconFromDay(weatherData: weatherData, _date: DateHandler.todaysDate)
        let TomorrowTemperaturesIconList = GetTemperatureIconFromDay(weatherData: weatherData, _date: DateHandler.tomorrowsDate)
      
        //calculating temperatures(average - min - max)
        let TodayTemperature = Temparetures(_avg: Average(Temp: TodayTemperaturesIconList.Tempareture), _min: Minimum(Temp: TodayTemperaturesIconList.Tempareture), _max: Maximum(Temp: TodayTemperaturesIconList.Tempareture))
        let TomorrowTemperature = Temparetures(_avg: Average(Temp: TomorrowTemperaturesIconList.Tempareture), _min: Minimum(Temp: TomorrowTemperaturesIconList.Tempareture), _max: Maximum(Temp: TomorrowTemperaturesIconList.Tempareture))
        
        //Getting the suitable icon
        let TodayIconString : String = TodayTemperaturesIconList.icon[0]
        let TomorrowIconString : String = TomorrowTemperaturesIconList.icon[TomorrowTemperaturesIconList.icon.count / 2]
     
        //assigning values to the main variables
        TodayData = WeatherDay(temperature: TodayTemperature, _date: DateHandler.todaysDate,_icon: TodayIconString)
        TomorrowData = WeatherDay(temperature: TomorrowTemperature, _date: DateHandler.tomorrowsDate,_icon: TomorrowIconString)
    }
    
    
    func GetTemperatureIconFromDay(weatherData : WeatherData,_date: String) -> (Tempareture: [Temparetures],icon: [String]) {
        var Temp : [Temparetures] = []
        var iconStringList : [String] = []
        for DataPoint in weatherData.list {
            if setDateToHndlerDate(Date: DataPoint.dt_txt) == _date {
                Temp.append(Temparetures(_avg: DataPoint.main.temp, _min: DataPoint.main.temp_min, _max: DataPoint.main.temp_max))
                iconStringList.append((DataPoint.weather.first?.icon)!)
            }
        }
        return(Temp,iconStringList)
    }
    

    func Maximum(Temp : [Temparetures]) -> Double {
        return Temp.map{$0.max}.max()!
        
    }
    func Minimum(Temp : [Temparetures]) -> Double {
        return Temp.map{$0.min}.min()!
    }
    
    func Average(Temp : [Temparetures]) -> Double {
        return (Temp.map{$0.avg}.reduce(0,+))/Double(Temp.count)
    }
    
    func setDateToHndlerDate(Date: String) -> String {
        let endIndex = Date.index(Date.startIndex, offsetBy: DateHandler.Offset)
        return String(Date[..<endIndex])
    }
    

}
