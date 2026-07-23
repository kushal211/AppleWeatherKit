//
//  APIWeatherAvailability+Map.swift
//
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

extension Array where Element == APIWeatherAvailability {
    var weatherAvailability: WeatherAvailability {
        WeatherAvailability(
            minuteAvailability: contains(.forecastNextHour) ? .available : .temporarilyUnavailable,
            alertAvailability: contains(.weatherAlerts) ? .available : .temporarilyUnavailable
        )
    }

    var weatherProxy: WeatherProxy {
        WeatherProxy(
            availability: weatherAvailability,
            currentWeather: nil,
            dailyForecast: nil,
            hourlyForecast: nil,
            minuteForecast: nil,
            weatherAlerts: nil
        )
    }
}
