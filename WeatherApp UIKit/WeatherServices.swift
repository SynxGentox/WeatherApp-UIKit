//
//  WeatherServices.swift
//  WeatherApp UIKit
//
//  Created by Aryan Verma on 10/04/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badResponse
    case decodingError
}

class WeatherServices {
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?q="
    
    func fetchWeather(cityName: String, unit: String) async throws -> WeatherModel {
        guard let url = URL(string: "\(baseURL)\(cityName)&appid=\(Secrets.apiKey)&units=\(unit)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        do {
            return try JSONDecoder().decode(WeatherModel.self, from: data)
        }
        catch {
            throw NetworkError.decodingError
        }
    }
}
