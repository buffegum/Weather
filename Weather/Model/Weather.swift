//
//  Weather.swift
//  Weather
//
//  Created by Дмитрий  Ванчугов on 08.04.2022.
//

import Foundation

struct Weekly: Codable {
    var date: String
    var minTemp: Int
    var maxTem: Int
}

struct Weather: Codable{
    var name: String = ""
    var temperature: Int = 0
    var url: String = ""
    var condition: String = ""
    var pressureMm: Int = 0
    var windSpeed: Double = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    var humidity: Int = 0
    var weekly: [Weekly] = []
    
    

    init?(weatherDate: WeatherData) {
        name = weatherDate.geoObject.locality.name
        temperature = weatherDate.fact.temp
        url = weatherDate.info.url
        condition = weatherDate.fact.condition.rawValue
        pressureMm = weatherDate.fact.pressureMm
        windSpeed = weatherDate.fact.wind_speed
        humidity = weatherDate.fact.humidity
        for i in weatherDate.forecasts{
            weekly.append(Weekly(date: i.date , minTemp: i.parts.night.tempMin , maxTem: i.parts.day.tempMax))
        }
    }
    
    init() {
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case name, temperature, url, condition, pressureMm, windSpeed, humidity, temp, tempMax, tempMin, weekly
    }
    
     public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self , forKey: .name)
        self.temperature = try container.decode(Int.self, forKey: .temperature)
        self.url = try container.decode(String.self, forKey: .url )
        self.condition = try container.decode(String.self, forKey: .condition )
        self.pressureMm = try container.decode(Int.self, forKey: .pressureMm )
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed )
        self.tempMin = try container.decode(Int.self, forKey: .tempMin )
        self.tempMax = try container.decode(Int.self, forKey: .tempMax )
        self.humidity = try container.decode(Int.self, forKey: .humidity)
         self.weekly = try container.decode([Weekly].self, forKey: .weekly)
    }
    
    public func encode(to encoder:Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name , forKey: .name)
        try container.encode(self.temperature , forKey: .temperature)
        try container.encode(self.url, forKey: .url)
        try container.encode(self.condition, forKey: .condition)
        try container.encode(self.pressureMm, forKey: .pressureMm)
        try container.encode(self.windSpeed, forKey: .windSpeed)
        try container.encode(self.tempMin, forKey: .tempMin)
        try container.encode(self.tempMax, forKey: .tempMax)
        try container.encode(self.humidity, forKey: .humidity)
        try container.encode(self.weekly, forKey: .weekly)
        
    }
    
    
}

extension UserDefaults {
    func set<T:Encodable>(encodable: T, for key: String){
        if let data = try? JSONEncoder().encode(encodable){
            set(data, forKey:  key)
        }
    }
    func value<T:Decodable>(_ type: T.Type , for key: String) ->T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data){
            return value
        }
        return nil
    }
    
    
}




