//
//  Geocoder+Mock.swift
//  
//
//  Created by Kushal Panchal on 7/23/26.
//

@testable import AppleWeatherKit
import Foundation

#if canImport(CoreLocation)
extension Geocoder {
    static let mock = Self(
        countryCode: { _ in "" },
        timezone: { _ in TimeZone(secondsFromGMT: 0)!.identifier }
    )
}
#endif
