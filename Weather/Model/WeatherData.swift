import Foundation



struct WeatherData:Decodable {
    
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
    let geoObject: GeoObject
    
    
    enum CodingKeys: String, CodingKey {
           case info
           case geoObject = "geo_object"
           case fact
           case forecasts
       }
}

struct Info:Decodable {
    let url: String

}

struct Fact: Decodable {
    let temp: Int
    let condition: Condition
    let wind_speed: Double
    let pressureMm: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {

        case temp
        case condition
        case wind_speed = "wind_speed"
        case pressureMm = "pressure_mm"
        case humidity
    }
}

struct Forecast:Decodable {
    let parts: Parts
    let date: String

}

struct Parts:Decodable {
    let day: Day
    let night: Night
}

struct Night: Decodable {
    let tempMin: Int
    
    enum CodingKeys: String, CodingKey{
        case tempMin = "temp_min"
        
    }
}

struct Day: Decodable {
    let tempMax: Int

    enum CodingKeys: String, CodingKey{
        case tempMax = "temp_max"
    }
}


enum Condition: String, Codable {
    case clear = "clear"
    case cloudy = "cloudy"
    case lightRain = "light-rain"
    case overcast = "overcast"
    case partlyCloudy = "partly-cloudy"
}





struct GeoObject: Decodable {
    let locality: Country
}

struct Country: Decodable {
    let id: Int
    let name: String
}


