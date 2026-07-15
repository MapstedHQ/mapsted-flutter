# Usage

First, add `mapsted_flutter` as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  mapsted_flutter: ^0.0.9
```

Don't forget to `flutter pub get`.


## Setting the mapsted plugin config
Run below command in your project directory in terminal

```yaml
dart run mapsted_flutter:create
```

## Platform Specific Configurations

### iOS 

- Project/ios/Podfile Add source file on top.

```sh
source 'https://cdn.cocoapods.org/'

# To run in simulator add below source target
source 'https://github.com/Mapsted/podspec-simulator.git'

# To run in device add below source target
source 'https://github.com/Mapsted/podspec.git'
```

- Project/ios/Podfile set use frameworks in your app target

```sh
use_frameworks!
```

#### IMPORTANT
- Add license file in Resources folder `your_ios_license.key`


### Android

1. Set the `minSdkVersion` in `android/app/build.gradle`:

```groovy
android {
    defaultConfig {
        minSdkVersion 24
    }
}
```

Make sure to save your changes and sync your project with Gradle to apply these configurations.


#### IMPORTANT
- Add license file in Assets folder('/app/src/main/assets') `your_android_license.key`



### Example

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

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
      appBar: AppBar(
        title: const Text('Mapsted Plugin Demo'),
      ),
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

See `example.dart` linked example for more info.
