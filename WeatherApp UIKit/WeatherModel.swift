//
//  WeatherModel.swift
//  WeatherApp UIKit
//
//  Created by Aryan Verma on 10/04/26.
//

import Foundation

struct WeatherModel: Codable {
    let name: String
    let main: MainWeather
    let weather: [WeatherCondition]
}

struct MainWeather: Codable {
    let temp: Double
}

struct WeatherCondition: Codable{
    let description: String
    let id: Int
}
