//
//  Weather.swift
//  Weather
//
//  Created by Дмитрий  Ванчугов on 08.04.2022.
//

import Foundation

struct Weather {
    var name: String = ""
    var temperature: Int = 0
    var url: String = ""
    var condition: String = ""
    var pressureMm: Int = 0
    var windSpeed: Double = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    var humidity: Int = 0
    var temp : [(String, Int, Int)] =  []
    
    
//    var conditionString: String {
//        switch condition {
//        case "clear":
//            return "Ясно"
//        default:
//            <#code#>
//        }
//    }
    
    init?(weatherDate: WeatherData) {
//        name = "dasd"
        name = weatherDate.geoObject.locality.name
        temperature = weatherDate.fact.temp
        url = weatherDate.info.url
        condition = weatherDate.fact.condition.rawValue
        pressureMm = weatherDate.fact.pressureMm
        windSpeed = weatherDate.fact.wind_speed
        humidity = weatherDate.fact.humidity
        for i in weatherDate.forecasts {
            temp.append((i.date, i.parts.night.tempMin, i.parts.day.tempMax))
        }
        
    }
    init() {
    }
}


