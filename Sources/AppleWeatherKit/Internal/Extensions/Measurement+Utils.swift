//
//  Measurement+Utils.swift
//  apple-weather-kit
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

extension Measurement where UnitType == UnitLength {
    static var zeroMillimeters: Measurement {
        Measurement(value: 0.0, unit: .millimeters)
    }

    static func millimeters(_ value: Double) -> Measurement {
        Measurement(value: value, unit: .millimeters)
    }
}
