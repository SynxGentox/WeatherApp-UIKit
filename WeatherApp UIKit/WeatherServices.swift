//
//  WeatherServices.swift
//  WeatherApp UIKit
//
//  Created by Aryan Verma on 10/04/26.
//

import Foundation

/// Holds the netword error states
enum NetworkError: Error {
    case invalidURL
    case badResponse
    case decodingError
}

/// Network Service class , manages API services
class WeatherServices {
    /// Holds the URL of weather API
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?q="
    
    /// Fetches the data through the URL form api and receives the data in the JSON format
    /// - Parameters:
    ///   - cityName: uses the city name to recieve the data for particular city
    ///   - unit: holds unit of the Temp
    /// - Returns: throws error accord to the output if Failed otherwise returns the decoded data
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
