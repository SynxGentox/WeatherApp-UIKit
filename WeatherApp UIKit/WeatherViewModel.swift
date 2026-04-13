//
//  WeatherViewModel.swift
//  WeatherApp UIKit
//
//  Created by Aryan Verma on 11/04/26.
//

import Foundation

///  ViewModel - data model for the UI 
class WeatherViewModel {
    
    /// - Parameters: Recieves the result from weatherServices and input form the user
    private let result: WeatherServices = WeatherServices()
    var cityName: String = "---"
    var unit: String = "metric"
    var temperature: String = "---"
    var weatherCondition: String = "---"
    var conditionId: Int = 0
    
    
    /// Updates the UI / Observable of UIkit but manual
    var update: (() -> Void)?
    /// updated the UI with error if caught any
    var error: ((Error) -> Void)?
    
    /// Function to receive / fetch weather data from the weather services also handles errors according to the required parameters
    /// - Parameters:
    ///   - city: receives the weather name for the city name
    ///   - unit: receives the weather data according to the Unit
    /// - Returns: returs the weather updated data to the UI through the null closure for update OR error through error closure including the city weather name, temp as per unit and weather condition description
    func fetchWeather(city: String, unit: String) -> Void {
        Task {
//            try? await Task.sleep(nanoseconds: 2_000_000_000)
            do {
                let weatherData = try await result.fetchWeather(cityName: city, unit: unit)
                self.cityName = weatherData.name
                self.temperature = String(format: "%.1f°C", weatherData.main.temp)
                self.weatherCondition = weatherData.weather.first?.description ?? "---"
                self.conditionId = weatherData.weather.first?.id ?? 0
                DispatchQueue.main.async {
                    self.update?()
                }
            } catch {
                
                DispatchQueue.main.async {
                    self.error?(error)
                }
            }
        }
    }
}
