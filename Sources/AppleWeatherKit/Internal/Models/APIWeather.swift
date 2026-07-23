//
//  APIWeather.swift
//
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

// MARK: - APIWeather
struct APIWeather: Codable, Equatable {
    let currentWeather: APICurrentWeather?
    let forecastDaily: APIForecastDaily?
    let forecastHourly: APIForecastHourly?
    let forecastNextHour: APIForecastNextHour?
    let historicalComparisons: APIHistoricalComparisons?
    let weatherAlerts: APIWeatherAlerts?
    let weatherChanges: APIWeatherChanges?

    enum CodingKeys: String, CodingKey {
        case currentWeather = "currentWeather"
        case forecastDaily = "forecastDaily"
        case forecastHourly = "forecastHourly"
        case forecastNextHour = "forecastNextHour"
        case historicalComparisons = "historicalComparisons"
        case weatherAlerts = "weatherAlerts"
        case weatherChanges = "weatherChanges"
    }
}
