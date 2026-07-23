<div align="center">

# 🌤️ AppleWeatherKit

### A native Swift wrapper around Apple's [WeatherKit REST API](https://developer.apple.com/documentation/weatherkitrestapi)

*Bring WeatherKit to Linux, servers, and every platform Apple doesn't support — with an API nearly identical to Apple's own [WeatherKit](https://developer.apple.com/documentation/weatherkit).*

<br/>

[![Linux Swift](https://github.com/kushal211/AppleWeatherKit/actions/workflows/swift-ubuntu.yml/badge.svg)](https://github.com/kushal211/AppleWeatherKit/actions?query=workflow%3Aswift-ubuntu)
[![macOS](https://github.com/kushal211/AppleWeatherKit/actions/workflows/swift-macos.yml/badge.svg)](https://github.com/kushal211/AppleWeatherKit/actions?query=workflow%3Aswift-macos)
[![Swift 5.9+](https://img.shields.io/badge/Swift-5.9%2B-orange.svg)](https://swift.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

</div>

---

## 📚 Table of Contents

- [Requirements](#-requirements)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
  - [Swift Package Manager (Xcode)](#swift-package-manager-xcode)
  - [Swift Package Manager (Package.swift)](#swift-package-manager-packageswift)
  - [Local Package (in-repo)](#local-package-in-repo)
  - [Manual Installation](#manual-installation)
- [Apple Developer Portal Setup](#-apple-developer-portal-setup)
  - [1. Enable the WeatherKit capability on your App ID](#1-enable-the-weatherkit-capability-on-your-app-id)
  - [2. Register a Services ID](#2-register-a-services-id)
  - [3. Create a WeatherKit private key](#3-create-a-weatherkit-private-key)
  - [4. Find your Team ID](#4-find-your-team-id)
- [Generating the JWT](#-generating-the-jwt)
- [Usage](#-usage)
- [Attribution](#-attribution)

## 💻 Requirements

Minimum Swift version of **5.9**.

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 13+             |
| watchOS  | 6+              |
| tvOS     | 13+             |
| visionOS | 1+              |
| macOS    | 11+             |
| Ubuntu   | 18.04+          |

## 📋 Prerequisites

Before you can make a single request, you need the following from Apple. Each of these
is created in the [Apple Developer Portal](https://developer.apple.com/account/resources/)
and is required to build the JSON Web Token (JWT) that authenticates every WeatherKit REST call.

| What you need | Used for | Where it comes from |
|---------------|----------|---------------------|
| **Apple Developer Program membership** (paid) | Access to WeatherKit | [developer.apple.com/programs](https://developer.apple.com/programs/) |
| **App ID with the WeatherKit capability enabled** | Grants your identifiers access to the WeatherKit service | [Identifiers](https://developer.apple.com/account/resources/identifiers/list) → App IDs |
| **Services ID (Identifier)** | JWT `sub` (subject) claim | [Identifiers](https://developer.apple.com/account/resources/identifiers/list) → Services IDs |
| **WeatherKit private key (`.p8`) + Key ID** | Signs the JWT (`kid` header) | [Keys](https://developer.apple.com/account/resources/authkeys/list) |
| **Team ID** | JWT `iss` (issuer) claim | [Membership](https://developer.apple.com/account/#/membership) |

> Follow the [Apple Developer Portal Setup](#-apple-developer-portal-setup) section below for step-by-step
> instructions on generating each of these.

## 📦 Installation

### Swift Package Manager (Xcode)

1. In Xcode, open your project and choose **File ▸ Add Package Dependencies…**
2. In the search field, paste the package URL:
   ```
   https://github.com/kushal211/AppleWeatherKit.git
   ```
3. Choose the **Dependency Rule** (e.g. *Up to Next Major Version*) and click **Add Package**.
4. Select the **AppleWeatherKit** library product and add it to your app target.
5. `import AppleWeatherKit` wherever you need it.

### Swift Package Manager (Package.swift)

Add the dependency to your `Package.swift`:

```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "YourApp",
    dependencies: [
        .package(url: "https://github.com/kushal211/AppleWeatherKit.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "YourApp",
            dependencies: [
                .product(name: "AppleWeatherKit", package: "AppleWeatherKit"),
            ]
        ),
    ]
)
```

### Local Package (in-repo)

If you keep AppleWeatherKit inside your repository (for example under `LocalPackages/AppleWeatherKit`),
reference it by path instead of by URL.

**In Xcode:** choose **File ▸ Add Package Dependencies… ▸ Add Local…**, then select the
`AppleWeatherKit` folder and add the **AppleWeatherKit** product to your target.

**In `Package.swift`:**

```swift
dependencies: [
    .package(path: "LocalPackages/AppleWeatherKit"),
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "AppleWeatherKit", package: "AppleWeatherKit"),
        ]
    ),
]
```

### Manual Installation

If you prefer not to use SPM, you can add the sources directly:

1. Clone or download this repository.
2. Drag the `Sources/AppleWeatherKit` folder into your Xcode project. When prompted, tick
   **Copy items if needed** and **Create groups**, and add it to the relevant target(s).
3. Make sure the `Sources/AppleWeatherKit/Resources` folder is included so the bundled
   localization (`Localizable.strings`) ships with your app.
4. `import AppleWeatherKit` and build.

> **Note:** On Linux the package depends on
> [async-http-client](https://github.com/swift-server/async-http-client); SPM resolves this
> automatically. Manual installation is intended for Apple platforms.

## ⚙️ Apple Developer Portal Setup

The REST API requires a signed JWT to be sent with each request. Complete all four steps below.

### 1. Enable the WeatherKit capability on your App ID

1. Go to [Identifiers](https://developer.apple.com/account/resources/identifiers/list).
2. Select (or create with the **+** button) the **App ID** you use for your app.
3. In the list of capabilities, tick **WeatherKit**.
4. Click **Save** (confirm the modification if prompted).

> Enabling WeatherKit on the App ID is what actually grants your account access to the service.
> Without this step, requests will fail even with a correctly signed JWT.

### 2. Register a Services ID

1. Go to [Identifiers](https://developer.apple.com/account/resources/identifiers/list).
2. On the top left, click the add button (**+**), select **Services IDs**, then click **Continue**.
3. Register a Service ID (provide a description and a reverse-domain identifier, e.g. `com.yourcompany.weather`).
4. **Make note of the Identifier** — this is your `SERVICE_IDENTIFIER` (the JWT `sub` claim).
5. Click **Continue**, review the registration information, and click **Register**.

### 3. Create a WeatherKit private key

1. Go to [Keys](https://developer.apple.com/account/resources/authkeys/list).
2. On the top left, click the add button (**+**).
3. Give your key a name and tick the **WeatherKit** box.
4. Click **Continue**, review the registration information, and click **Register**.
5. **Make note of the Key ID** — this is your `KEY_ID` (the JWT `kid` header).
6. **Download the private key** (`.p8` file). You can only download it once — store it securely.

### 4. Find your Team ID

Your **Team ID** is your `TEAM_ID` (the JWT `iss` claim). Find it under
[Membership details](https://developer.apple.com/account/#/membership) in the developer portal.

## 🔑 Generating the JWT

The WeatherKit REST API requires a JSON Web Token (JWT) to be sent with every request. Implementing the
logic necessary to generate a JWT is beyond the scope of the AppleWeatherKit project at this time.
For general information on JWT please visit https://jwt.io

That being said, the recommended package to handle this task is Vapor's [jwt-kit](https://github.com/vapor/jwt-kit). Here is how to set that up:

Implement a model conforming to `JWTPayload`:

```swift
import JWTKit

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
```

Generate the JWT:

```swift
struct JWTProvider {
    static func generate() async throws -> String {
        let keys = JWTKeyCollection()
        try await keys.add(ecdsa: ES256PrivateKey(pem: PRIVATE_KEY_FROM_DEV_PORTAL))

        let payload = Payload(
            expiration: .init(value: .distantFuture),
            issued: .init(value: .now),
            issuer: TEAM_ID,
            subject: SERVICE_IDENTIFIER
        )

        return try await keys.sign(payload, kid: KEY_ID)
    }
}
```

Note the variables:

`PRIVATE_KEY_FROM_DEV_PORTAL`: The contents of the private key file including
`-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----`

`TEAM_ID`: Found in Membership Details on the developer portal

`SERVICE_IDENTIFIER`: The reverse-domain name noted earlier

`KEY_ID`: The ID of the service key

## 🌤️ Usage

`import AppleWeatherKit` in any file where you use the service.

### Initialize Service

The service must be initialized with a JWT generating closure and optionally a language.

```swift
import AppleWeatherKit

let weatherService = WeatherService(
    configuration: .init(jwt: { try await JWTProvider.generate() })
)
```

### Get a Full Weather Forecast

```swift
let weather = try await weatherService
    .weather(
        for: Location(
            latitude: 37.541290,
            longitude: -77.511429),
        countryCode: "US"
    )
```

### Get a Partial Weather Forecast

```swift
let (dailyForecast, hourlyForecast, alerts) = try await weatherService
    .weather(
        for: Location(
            latitude: 37.541290,
            longitude: -77.511429),
        including: .daily, .hourly, .alerts(countryCode: "US")
    )
```

### Get Availability

Note that minute forecasts and alerts are not always available in all regions. Use the `.availability` query check their availability.

```swift
let availability = try await weatherService
    .weather(
        for: Location(
            latitude: 37.541290,
            longitude: -77.511429),
        including: .availability
    )
```

### Get Weather Statistics

Historical weather statistics are derived from weather data recorded over the past decades. Statistics are available at daily, hourly, and monthly intervals.

**Daily Statistics** (30 days ago to 10 days from now by default):

```swift
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        including: .precipitation, .temperature
    )
```

**Daily Statistics** (specific day range, 1-366):

```swift
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        startDay: 1,
        endDay: 10,
        including: .precipitation, .temperature
    )
```

**Hourly Statistics** (24 hours of current day by default):

```swift
let hourlyTemperature = try await weatherService
    .hourlyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        including: .temperature
    )
```

**Hourly Statistics** (specific hour range, 1-8784):

```swift
let hourlyTemperature = try await weatherService
    .hourlyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        startHour: 1,
        endHour: 24,
        including: .temperature
    )
```

**Monthly Statistics** (all 12 months by default):

```swift
let (monthlyPrecipitation, monthlyTemperature) = try await weatherService
    .monthlyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        including: .precipitation, .temperature
    )
```

**Monthly Statistics** (specific month range, 1-12):

```swift
let (monthlyPrecipitation, monthlyTemperature) = try await weatherService
    .monthlyStatistics(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        startMonth: 1,
        endMonth: 6,
        including: .precipitation, .temperature
    )
```

### Get Weather Summaries

Weather summaries provide aggregated actual weather data (not statistics) for past dates.

**Daily Summary** (past 30 days by default):

```swift
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailySummary(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        including: .precipitation, .temperature
    )
```

**Daily Summary** (specific day range, 1-366):

```swift
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailySummary(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        startDay: 1,
        endDay: 10,
        including: .precipitation, .temperature
    )
```

**Daily Summary** (specific date interval):

```swift
let interval = DateInterval(start: startDate, end: endDate)
let (dailyPrecipitation, dailyTemperature) = try await weatherService
    .dailySummary(
        for: Location(latitude: 37.541290, longitude: -77.511429),
        forDaysIn: interval,
        including: .precipitation, .temperature
    )
```

### Geocoding for Country Code (Apple platforms only)

When the library is used on an Apple platform, the `countryCode` and `timezone` parameters are not required. Internally, the library will use `CoreLocation` to reverse geocode the location to determine the country code. If the country cannot be determined, an error will be thrown.

### Example App

A complete SwiftUI example app demonstrating every public API method is included under
[`Example/AppleWeatherKitExample`](Example/AppleWeatherKitExample).

To run it:

1. Open `Example/AppleWeatherKitExample/AppleWeatherKitExample.xcodeproj` in Xcode.
2. Open **`WeatherKitCredentials.swift`** — all credentials live in this one file — and replace
   each placeholder with your own values from the [Apple Developer Portal Setup](#-apple-developer-portal-setup):

   ```swift
   enum WeatherKitCredentials {
       static let teamID            = "YOUR_TEAM_ID"            // JWT `iss` — Membership details
       static let serviceIdentifier = "YOUR_SERVICE_IDENTIFIER" // JWT `sub` — Identifiers → Services IDs
       static let keyID             = "YOUR_KEY_ID"             // JWT `kid` — Keys (WeatherKit key)
       static let privateKey = """
           -----BEGIN PRIVATE KEY-----
           YOUR_PRIVATE_KEY_CONTENTS_HERE
           -----END PRIVATE KEY-----
           """
   }
   ```

   `ExampleApp.swift` reads these values in its `JWTProvider` to sign the token — you don't need to edit it.
3. Select an iOS Simulator (or device) and run.

> ⚠️ **Never commit real credentials.** `WeatherKitCredentials.swift` ships with placeholders only.
> The private key is a secret — treat the `.p8` contents like a password and keep real values out of
> source control (e.g. via a git-ignored file, environment variables, or your build configuration).

## 📝 Attribution

Please be advised of [Apple's attribution guidelines](https://developer.apple.com/weatherkit/get-started/#attribution-requirements) when using this package.

Attribution information can be accessed with:

```swift
let attribution = weatherService.attribution
```

Note that this property returns a static `WeatherAttribution` instance using information from `WeatherKit` and is not guaranteed to be accurate or complete.
