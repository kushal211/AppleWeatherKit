//
//  WeatherMetadata.swift
//  
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

/// A structure that provides additional weather information.
@available(macOS 11, iOS 13, watchOS 6, tvOS 13, visionOS 1, *)
public struct WeatherMetadata: Sendable {

    /// The date of the weather data request.
    public var date: Date

    /// The time the weather data expires.
    public var expirationDate: Date

    /// The location of the request.
    public var location: Location
}

extension WeatherMetadata: Codable {}
extension WeatherMetadata: Equatable {}
