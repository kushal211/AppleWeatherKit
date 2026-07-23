//
//  APIWeatherAlerts+Map.swift
//
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

extension APIWeatherAlerts {
    var weatherAlerts: [WeatherAlert] {
        alerts.map {
            WeatherAlert(
                detailsURL: detailsURL,
                metadata: metadata.weatherMetadata,
                alert: $0.alertSummary
            )
        }
    }
}

extension APIAlertSummary {
    var alertSummary: AlertSummary {
        AlertSummary(
            id: id,
            areaID: areaID,
            areaName: areaName,
            attributionURL: attributionURL,
            countryCode: countryCode,
            alertDescription: alertDescription,
            effectiveTime: effectiveTime,
            expireTime: expireTime,
            issuedTime: expireTime,
            detailsURL: detailsURL,
            phenomenon: phenomenon,
            severity: WeatherSeverity(rawValue: severity) ?? .unknown,
            source: source,
            eventSource: eventSource,
            urgency: AlertUrgency(rawValue: urgency) ?? .unknown,
            certainty: Certainty(rawValue: certainty) ?? .unknown,
            importance: importance,
            responses: responses.compactMap(WeatherResponse.init(rawValue:))
        )
    }
}
