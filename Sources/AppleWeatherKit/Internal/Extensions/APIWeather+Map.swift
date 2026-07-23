//
//  APIWeather+Map.swift
//  
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

extension APIWeather {
    var weatherProxy: WeatherProxy {
        WeatherProxy(
            availability: nil,
            currentWeather: currentWeather?.currentWeather,
            dailyForecast: forecastDaily?.dailyForecast,
            hourlyForecast: forecastHourly?.hourForecast,
            minuteForecast: forecastNextHour?.minuteForecast,
            weatherAlerts: weatherAlerts?.weatherAlerts
        )
    }
}
