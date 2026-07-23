//
//  APIMetadata+Map.swift
//  
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

extension APIMetadata {
    var weatherMetadata: WeatherMetadata {
        WeatherMetadata(
            date: readTime,
            expirationDate: expireTime,
            location: Location(latitude: latitude, longitude: longitude)
        )
    }
}
