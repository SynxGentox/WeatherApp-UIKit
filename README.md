# WeatherApp UIKit

A programmatic UIKit weather app built without Storyboard.
Fetches real-time weather data using the OpenWeatherMap API.

## Features
- Real-time weather by city search
- Dynamic background color based on weather condition
- Weather icon updates based on live condition ID
- Temperature in Celsius / Fahrenheit
- 5-day forecast table (static UI)
- Loading indicator while fetching
- Error handling with alert dialog

## Architecture
- **MVVM** — WeatherViewModel handles all data logic
- **WeatherServices** — async/await URLSession network layer
- **WeatherConditionHelper** — maps condition IDs to SF Symbols and background colors

## Tech Stack
- Swift 5
- UIKit (100% programmatic, no Storyboard)
- async/await
- OpenWeatherMap API

## Setup
1. Clone the repo
2. Add your API key in `Secrets.swift` as `Secrets.apiKey`
3. Build and run on iOS 16+
