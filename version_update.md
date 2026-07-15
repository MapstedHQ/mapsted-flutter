## For changing version of sdk and publish new version of plugin on pub.dev.

## mapsted-flutter

### 1. Open android/build.gradle file find sdk version and replace updated version number all place.

### Android
```sh
    def mapstedSdkVersion = '6.0.14'
```

### 2. Open mapsted_flutter.podspec file find sdk version and replace updated version number all place.

### iOS
```sh
    s.dependency 'mapsted-sdk-map', '6.1.9'
    s.dependency 'mapsted-sdk-map-ui', '6.1.9'
    s.dependency 'mapsted-sdk-geofence', '6.1.9'
```

### 3. Open pubspec.yaml file find version (version: <version_number>) and update version number.


### 4. Publish package
```sh 
    dart pub publish --dry-run
    dart pub publish
```
