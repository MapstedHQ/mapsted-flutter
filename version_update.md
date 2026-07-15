## Changing the native SDK version and publishing a new plugin release

### HARD RULE — keep the version consistent with the native SDK
The plugin's published version MUST equal the native Mapsted SDK version it wraps (e.g. native 26.7.1 →
plugin `26.7.1`). Do **not** drift the plugin version away from the SDK version to dodge a registry collision.

### 1. Android — `android/build.gradle`, `android/build-extra.gradle`, `android/app-build-extra.gradle`, `android/build.gradle.template`
```sh
    def mapstedSdkVersion = '26.7.1'
    implementation "com.mapsted:android-sdk-ui:${mapstedSdkVersion}"
    implementation "com.mapsted:android-sdk-map:${mapstedSdkVersion}"
    implementation "com.mapsted:android-sdk-core:${mapstedSdkVersion}"
```
Repository: `maven { url = uri("https://mapstedhq.github.io/mapsted-android-maven") }`
(NOT jitpack / Artifactory — removed at 26.7.1).

### 2. iOS — `ios/mapsted_flutter.podspec`
```sh
    s.dependency 'mapsted-sdk-map', '~> 26.7.1'
    s.dependency 'mapsted-sdk-map-ui', '~> 26.7.1'
    # geofence folded into core at 26.7.1 — pod dropped
```
Podfile sources: `cdn.cocoapods.org` + `github.com/MapstedHQ/podspec.git` (NOT podspec-simulator).

### 3. `pubspec.yaml`
Set `version:` to match the native SDK version.

### 4. Publish (operator-gated — public push)
```sh
    dart pub publish --dry-run
    dart pub publish
```
