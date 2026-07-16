# mapsted_flutter

A Flutter plugin for integrating Mapsted's advanced indoor/outdoor location and mapping technology.
This release targets the **native Mapsted SDK 26.7.1**.

## Install

Add `mapsted_flutter` to your `pubspec.yaml` as a git dependency:

```yaml
dependencies:
  mapsted_flutter:
    git:
      url: https://github.com/MapstedHQ/mapsted-flutter.git
      ref: v26.7.1
```

Then run `flutter pub get`.

### Generate the platform config

From your app's project directory:

```sh
dart run mapsted_flutter:create
```

This injects the required Maven repository (Android) and Podfile sources (iOS) into your project.

## Consumer requirements (breaking — documented)

The Mapsted SDK 26.7.1 native artifacts set a hard toolchain floor. These are **major** requirements:

| | Minimum |
|---|---|
| Android `minSdkVersion` | **26** |
| Android Gradle Plugin | **8.9.1** |
| Kotlin | **2.3.20** |
| Gradle | **8.13** |
| iOS deployment target | **16.0** |

## Platform configuration

### iOS

Add these sources to the top of `ios/Podfile` (the `create` command does this for you):

```sh
source 'https://cdn.cocoapods.org/'
source 'https://github.com/MapstedHQ/podspec.git'

platform :ios, '16.0'
```

Enable frameworks in your app target:

```sh
use_frameworks!
```

Add your Mapsted licence file to the iOS `Runner` resources: `your_ios_license.key`.

### Android

Set `minSdkVersion` to **26** in `android/app/build.gradle`:

```groovy
android {
    defaultConfig {
        minSdkVersion 26
        // Required by the Mapsted SDK 26.7.1 AAR meta-data:
        manifestPlaceholders += [versionCode: "1", dateString: new Date().format('yyyyMMdd')]
    }
}
```

> `dart run mapsted_flutter:create` injects these placeholders for you via `build-extras.gradle`.

The map opens in `com.mapsted.ui.map.MapstedMapActivity`; ensure your app theme derives from a
Material/AppCompat theme. Add your Mapsted licence file under `android/app/src/main/assets/your_android_license.key`.

## Usage

The plugin exposes a fullscreen map launcher:

```dart
class MyHomePageState extends State<MyHomePage> {
  final MapstedFlutter mapsted = MapstedFlutter();

  Future<void> launchMapActivity() async {
    try {
      await mapsted.launchMapActivity();
    } catch (e) {
      print('Error launching map activity: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapsted Plugin Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: launchMapActivity,
          child: const Text("Launch Map"),
        ),
      ),
    );
  }
}
```

See `example/` for a complete, runnable app.
