import 'mapsted_flutter_platform_interface.dart';

/// A class that provides access to Mapsted's Flutter functionalities.
///
/// The `MapstedFlutter` class includes methods for interacting with
/// Mapsted services in a Flutter application. Currently, it supports
/// launching map activities.
class MapstedFlutter {
  /// Launches a map activity.
  ///
  /// This method uses the platform interface to initiate a map activity
  /// provided by Mapsted. It allows users to view and interact with
  /// maps within the application.
  ///
  /// Returns a [Future<void>] that completes when the map activity has
  /// been successfully launched. If the method encounters any issues,
  /// it may throw an exception.
  ///
  /// Example usage:
  /// ```dart
  /// final mapsted = MapstedFlutter();
  /// await mapsted.launchMapActivity();
  /// ```
  Future<void> launchMapActivity() {
    return MapstedFlutterPlatform.instance.launchMapActivity();
  }
}
