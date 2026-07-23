//
//  AppleWeatherKitExampleApp.swift
//  AppleWeatherKitExample
//
//  Created by Kushal Panchal on 7/23/26.
//

import SwiftUI
import AppleWeatherKit
import JWTKit

@main
struct ExampleApp: App {
    @State var viewModel: WeatherViewModel = WeatherViewModel(
        configuration: createWeatherConfiguration()
    )

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MethodListView(
                    viewModel: viewModel
                )
            }
        }
    }

    /// Creates the WeatherService configuration with JWT provider
    ///
    /// IMPORTANT: You must provide your own valid Apple WeatherKit JWT token
    /// to use this example app. The placeholder below will cause API calls to fail.
    ///
    /// To get started with Apple WeatherKit:
    /// 1. Sign up for an Apple Developer account
    /// 2. Create a WeatherKit service identifier in the Apple Developer Portal
    /// 3. Generate a private key and download it
    /// 4. Use a JWT library (e.g., vapor/jwt-kit) to generate tokens
    ///
    /// Required JWT claims:
    /// - exp: Expiration time (usually ~1 hour from now)
    /// - iat: Issued at time (current time)
    /// - iss: Issuer (your Team ID)
    /// - sub: Subject (your WeatherKit Service Identifier)
    ///
    /// The JWT must be signed with ES256 using your private key and include
    /// the Key ID in the header.
    ///
    /// For more information, see Apple's WeatherKit documentation:
    /// https://developer.apple.com/documentation/weatherkit
    private static func createWeatherConfiguration() -> WeatherService.Configuration {
        WeatherService.Configuration(
            jwt: {
                try await JWTProvider.generate()
            },
            language: .englishUS
        )
    }
}

struct Payload: JWTPayload, Equatable {
    enum CodingKeys: String, CodingKey {
        case expiration = "exp"
        case issued = "iat"
        case issuer = "iss"
        case subject = "sub"
    }

    let expiration: ExpirationClaim
    let issued: IssuedAtClaim
    let issuer: IssuerClaim
    let subject: SubjectClaim

    func verify(using key: some JWTAlgorithm) throws {}
}

struct JWTProvider {
    static func generate() async throws -> String {
        let keys = JWTKeyCollection()
        try await keys.add(ecdsa: ES256PrivateKey(pem: WeatherKitCredentials.privateKey))

        let payload = Payload(
            expiration: .init(value: .distantFuture),
            issued: .init(value: .now),
            issuer: IssuerClaim(value: WeatherKitCredentials.teamID),
            subject: SubjectClaim(value: WeatherKitCredentials.serviceIdentifier)
        )

        return try await keys.sign(payload, kid: JWKIdentifier(string: WeatherKitCredentials.keyID))
    }
}
