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
        //  these to variables will hold all the data and in the last will be assigned to TodayData & TomorrowData
        var TodayDataTemp = WeatherDay()
        var TomorrowDataTemp = WeatherDay()
        // setting the Date with DateHandler Class
        TodayDataTemp.date = DateHandler.todaysDate
        TomorrowDataTemp.date = DateHandler.tomorrowsDate
        var todayCount : Double = 0
        var TomorrrowCount : Double = 0
        guard let weatherData = weatherJSONData else { return }
        // Soting the data and calculating min max and avg temp
        for DataPoint in weatherData.list {
            var DataPointDate = DataPoint.dt_txt
            let endIndex = DataPointDate.index(DataPointDate.startIndex, offsetBy: DateHandler.Offset)
            DataPointDate =  String(DataPointDate[..<endIndex])
            if DataPointDate == DateHandler.todaysDate {
                TodayDataTemp.MaxTemp = max(TodayDataTemp.MaxTemp, DataPoint.main.temp_max)
                TodayDataTemp.MinTemp = min(TodayDataTemp.MinTemp, DataPoint.main.temp_min)
                TodayDataTemp.temp += DataPoint.main.temp
                todayCount += 1
            } else if DataPointDate == DateHandler.tomorrowsDate {
                TomorrowDataTemp.MaxTemp = max(TomorrowDataTemp.MaxTemp, DataPoint.main.temp_max)
                TomorrowDataTemp.MinTemp = min(TomorrowDataTemp.MinTemp, DataPoint.main.temp_min)
                TomorrowData?.temp += DataPoint.main.temp
                TomorrrowCount += 1
            }
        }
        //
        TomorrowDataTemp.temp /= TomorrrowCount
        TodayDataTemp.temp /= todayCount
        
        //converting from kelvin to celisius
        TodayDataTemp.temp -= 273.15
        TomorrowDataTemp.temp -= 273.15
        TodayDataTemp.MinTemp -= 273.15
        TomorrowDataTemp.MinTemp -= 273.15
        TodayDataTemp.MaxTemp -= 273.15
        TomorrowDataTemp.MaxTemp -= 273.15
        
        //taking the round to make it an integer
        TodayDataTemp.temp = round(10 * TodayDataTemp.temp / 10)
        TomorrowDataTemp.temp = round(10 * TomorrowDataTemp.temp / 10)
        TodayDataTemp.MinTemp = round(10 * TodayDataTemp.MinTemp / 10)
        TomorrowDataTemp.MinTemp = round(10 * TomorrowDataTemp.MinTemp / 10)
        TodayDataTemp.MaxTemp = round(10 * TodayDataTemp.MaxTemp / 10)
        TomorrowDataTemp.MaxTemp = round(10 * TomorrowDataTemp.MaxTemp / 10)
        
        //assigning values to the main variables
        TodayData = TodayDataTemp
        TomorrowData = TomorrowDataTemp
        
    }
}
