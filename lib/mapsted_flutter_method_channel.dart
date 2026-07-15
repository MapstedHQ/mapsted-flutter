import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mapsted_flutter_platform_interface.dart';

/// An implementation of [MapstedFlutterPlatform] using a [MethodChannel].
///
/// This class interacts with the platform-specific implementation of the
/// Mapsted Flutter SDK via a [MethodChannel]. It allows for invoking
/// platform methods to perform actions such as launching map activities.
class MethodChannelMapstedFlutter extends MapstedFlutterPlatform {
  final MethodChannel _methodChannel = const MethodChannel('mapsted_flutter');

  /// Launches a map activity on the platform.
  ///
  /// This method sends a request to the platform side to initiate a map
  /// activity. It uses the [MethodChannel] to communicate with the
  /// platform, passing parameters to customize the map activity.
  ///
  /// The parameters include:
  /// - `setEnablePropertyListSelection`: A boolean that enables or
  ///   disables property list selection.
  /// - `setShowPropertyListOnMapLaunch`: A boolean that determines whether
  ///   to show the property list when the map activity is launched.
  ///
  /// If an error occurs while invoking the method, it is caught and
  /// printed using [debugPrint]. The exception is then rethrown to be
  /// handled by the caller.
  ///
  /// Example usage:
  /// ```dart
  /// final mapsted = MethodChannelMapstedFlutter();
  /// try {
  ///   await mapsted.launchMapActivity();
  /// } catch (e) {
  ///   // Handle the error
  /// }
  /// ```
  @override
  Future<void> launchMapActivity() async {
    try {
      await _methodChannel.invokeMethod('launchMapActivity', {
        'setEnablePropertyListSelection': true,
        'setShowPropertyListOnMapLaunch': true,
      });
    } on PlatformException catch (e) {
      debugPrint('Error launching map activity: ${e.message}');

      rethrow;
    }
  }
}
