## [26.7.1] - (2026-Jul-16)

- Migrate to native Mapsted SDK **26.7.1** (Android `com.mapsted:android-sdk-*:26.7.1`, iOS `mapsted-sdk-map`/`-map-ui` `~> 26.7.1`).
- **Breaking (consumer toolchain):** Android `minSdkVersion` 26, Kotlin 2.3.20, AGP 8.9.1, Gradle 8.13; iOS 16.
- Android: repositories moved to the GitHub-Pages Maven; added the required `manifestPlaceholders` (versionCode/dateString); added `appcompat`/`gson`.
- iOS: `mapsted-sdk-geofence` pod dropped (folded into core at 26.7.1); storyboard bundled as a resource; `RoutingRequestCallback` updated to the 26.7.1 signature.
- `create` scaffolder now supports modern Kotlin-DSL (`build.gradle.kts`) Android projects and adds real permission usage descriptions (including Bluetooth).

## [0.0.9] - (2025-Jun-25)

- Bump Mapsted Sdk Version.

## [0.0.8] - (2024-Oct-23)

- Bump Mapsted Sdk Version.

## [0.0.7] - (2024-Sept-04)

- Update MapstedFlutterPlugin file.

## [0.0.6] - (2024-Sept-02)

- Update MapstedFlutterPlugin file.

## [0.0.5] - (2024-Aug-30)

- Update MapstedFlutterPlugin file.

## [0.0.4] - (2024-Aug-30)

- Fix incorrect typecast in MapstedFlutterPlugin file.

## [0.0.3] - (2024-Aug-29)

- Update README.md

## [0.0.2] - (2024-Aug-29)

- Improve documentation

## [0.0.1] - (2024-Aug-27)

- Initial developers preview release.

