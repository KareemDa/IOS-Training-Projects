//
//  Weather Structures.swift
//  Weather App
//
//  Created by khalil on 8/28/18.
//  Copyright © 2018 Ejad. All rights reserved.
//

import Foundation
import UIKit

struct WeatherData : Codable {
    let list : [WeatherDataPoints]
    let city : City
}

struct WeatherDataPoints : Codable {
    let main : main
    let weather : [weather]
    let dt_txt : String
}

struct main : Codable {
    let temp : Double
    let temp_min : Double
    let temp_max : Double
}

struct weather : Codable {
    let main : String
    let icon : String
}


struct City : Codable {
    let name : String
    let country : String
}



struct Temparetures {
    var avg : Double
    var min : Double
    var max : Double
    
    init() {
        avg  = 0
        min = 100000
        max = -100000
    }
    
    init(_avg: Double, _min: Double,_max: Double) {
        avg = _avg
        max = _max
        min = _min
    }
    
     mutating func KelvinToCelsius() {
        avg = avg - 273.15
        min = min - 273.15
        max = max - 273.15
    }
}

struct WeatherDay {
    var avgTemp : Double
    var minTemp : Double
    var maxTemp : Double
    var date : String
    var icon : String
    
    init() {
        avgTemp  = 0
        minTemp = 100000
        maxTemp = -100000
        date = ""
        icon = ""
    }
    
    init(temperature : Temparetures,_date : String,_icon : String) {
        avgTemp = temperature.avg
        maxTemp = temperature.max
        minTemp = temperature.min
        date = _date
        icon = _icon
    }
    
    
}
