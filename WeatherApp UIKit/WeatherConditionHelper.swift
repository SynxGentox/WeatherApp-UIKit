//
//  WeatherConditionHelper.swift
//  WeatherApp UIKit
//
//  Created by Aryan Verma on 13/04/26.
//

import UIKit

struct WeatherConditionHelper {
    static func iconName(for conditionId: Int) -> String {
        switch conditionId {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "snowflake"
        case 700...781: return "cloud.fog.fill"
        case 800:       return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default:        return "sun.max.fill"
        }
    }
    
    static func backgroundColor(for conditionId: Int) -> UIColor {
        switch conditionId {
        case 200...232: return UIColor(
            red: 0.3,
            green: 0.3,
            blue: 0.4,
            alpha: 1
        ) // thunderstorm - dark purple grey
        case 300...321: return UIColor(
            red: 0.4,
            green: 0.6,
            blue: 0.8,
            alpha: 1
        ) // drizzle - light blue
        case 500...531: return UIColor(
            red: 0.2,
            green: 0.4,
            blue: 0.7,
            alpha: 1
        ) // rain - deep blue
        case 600...622: return UIColor(
            red: 0.8,
            green: 0.9,
            blue: 1.0,
            alpha: 1
        ) // snow - icy white
        case 700...781: return UIColor(
            red: 0.7,
            green: 0.6,
            blue: 0.5,
            alpha: 1
        ) // atmosphere - foggy brown
        case 800:       return UIColor(
            red: 0.3,
            green: 0.7,
            blue: 1.0,
            alpha: 1
        ) // clear - bright blue
        case 801...804: return UIColor(
            red: 0.5,
            green: 0.5,
            blue: 0.6,
            alpha: 1
        ) // cloudy - grey blue
        default:        return .systemBlue
        }
    }
}

