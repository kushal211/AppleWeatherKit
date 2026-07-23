//
//  WeatherKitCredentials.swift
//  AppleWeatherKitExample
//
//  Created by Kushal Panchal on 7/23/26.
//

import Foundation

/// Placeholder credentials required to sign the WeatherKit REST API JWT.
///
/// Replace every value below with your own from the Apple Developer Portal.
/// See the README's "Apple Developer Portal Setup" section for how to obtain each one.
///
/// ⚠️ Do NOT commit real credentials (especially `privateKey`) to source control.
/// Consider loading these from a secrets file, environment variables, or your
/// build configuration instead of hardcoding them.
enum WeatherKitCredentials {

    /// Your 10-character Apple Team ID — used as the JWT `iss` (issuer) claim.
    /// Found under Membership details in the Apple Developer Portal.
    static let teamID = "YOUR_TEAM_ID"

    /// Your WeatherKit Services ID — used as the JWT `sub` (subject) claim.
    /// Found under Identifiers → Services IDs.
    static let serviceIdentifier = "YOUR_SERVICE_IDENTIFIER"

    /// Your WeatherKit Key ID — used as the JWT `kid` header.
    /// Found under Keys (the key with the WeatherKit capability enabled).
    static let keyID = "YOUR_KEY_ID"

    /// The contents of the `.p8` private key you downloaded from the Apple Developer Portal.
    /// Keep the `-----BEGIN PRIVATE KEY-----` / `-----END PRIVATE KEY-----` lines.
    static let privateKey = """
        -----BEGIN PRIVATE KEY-----
        YOUR_PRIVATE_KEY_CONTENTS_HERE
        -----END PRIVATE KEY-----
        """
}
