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

struct WeatherDay {
    var temp : Double
    var MinTemp : Double
    var MaxTemp : Double
    var date : String
   // var icon : String
    
    init() {
        temp = 0
        MinTemp = 100000
        MaxTemp = -100000
        date = ""
    }
}
