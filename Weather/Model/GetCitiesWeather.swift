//
//  GetCitiesWeather.swift
//  Weather
//
//  Created by Дмитрий  Ванчугов on 12.04.2022.
//

import Foundation
import CoreLocation

let network = NetworkWeatherManager()

func getCityWeather (citiesArray: [String], competionHendler: @escaping (Int, Weather) -> () ){
    for (index,item) in citiesArray.enumerated() {
        getCoordinateFrom(city: item) { coordinates, error in
            guard let coordinates = coordinates, error == nil else {return}
            network.makeRequest(latitude: coordinates.latitude, longitude: coordinates.longitude) { weather in
                competionHendler(index,weather)
            }
        }
    }
}

func getCoordinateFrom(city:String, completion :@escaping (_ coordinate:CLLocationCoordinate2D?, _ error: Error?) -> () ){
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error )
        
    }
}
