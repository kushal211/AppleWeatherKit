//
//  APIWeatherAvailability.swift
//  
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

@usableFromInline
enum APIWeatherAvailability: String, Codable, Equatable {
    case currentWeather
    case forecastDaily
    case forecastHourly
    case forecastNextHour
    case weatherAlerts
}
