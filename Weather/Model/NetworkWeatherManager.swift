import Foundation

struct NetworkWeatherManager {
    //complitionHandler: @escaping (Weather)->()
    
    func makeRequest(latitude: Double, longitude:Double,completionHandler: @escaping (Weather) -> () ) {
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)") else {return}
        var request = URLRequest(url: url)
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request){ (data, responce, error) in
            guard let data = data else {
                //print(String(describing: error))
                return
            }
//            if let json = String(data: data, encoding: .utf8){
//                print(json)
//
//            }
            if let weather = parseJSON(from: data){
                print(weather)
            completionHandler(weather)

            }
    }
        task.resume()
}
    
    
    func parseJSON(from data: Data) -> Weather? {
        let decoder = JSONDecoder()
        
        do{
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherDate: weatherData) else{return nil}
            return weather
        }catch{
            print(error)
        }
        return nil
    }
}
