//
//  UnitSpeed.swift
//  apple-weather-kit
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

extension UnitSpeed {
    static let millimetersPerHour: UnitSpeed = UnitSpeed(symbol: "mm/h", converter: UnitConverterLinear(coefficient: 1.0/3.6))
}
