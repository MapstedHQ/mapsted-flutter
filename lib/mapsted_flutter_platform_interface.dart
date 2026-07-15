import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mapsted_flutter_method_channel.dart';

/// An abstract class that defines the platform interface for the Mapsted Flutter plugin.
///
/// This class serves as an abstraction layer for the Mapsted Flutter SDK, allowing
/// different platform-specific implementations (such as Android or iOS) to be used
/// interchangeably. It extends [PlatformInterface] to enforce platform interface
/// compliance and provides a mechanism for method invocation on the platform side.
///
/// The default implementation is provided by [MethodChannelMapstedFlutter], which
/// uses [MethodChannel] for communication between Flutter and native code.
///
/// To use this class, extend it and provide concrete implementations for the methods
/// in your platform-specific code.
abstract class MapstedFlutterPlatform extends PlatformInterface {
  MapstedFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  // Private static instance initialized with MethodChannel implementation
  static MapstedFlutterPlatform _instance = MethodChannelMapstedFlutter();

  /// The current instance of [MapstedFlutterPlatform].
  ///
  /// This getter returns the instance of [MapstedFlutterPlatform] that is currently
  /// being used. By default, this is an instance of [MethodChannelMapstedFlutter].
  ///
  /// Example usage:
  /// ```dart
  /// final platform = MapstedFlutterPlatform.instance;
  /// ```
  static MapstedFlutterPlatform get instance => _instance;

  /// Sets the instance of [MapstedFlutterPlatform].
  ///
  /// This setter allows for setting a custom instance of [MapstedFlutterPlatform].
  /// The provided instance must be verified against the interface token to ensure
  /// compliance with the platform interface.
  ///
  /// Example usage:
  /// ```dart
  /// MapstedFlutterPlatform.instance = CustomPlatformImplementation();
  /// ```
  static set instance(MapstedFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Launches a map activity.
  ///
  /// This abstract method must be implemented by subclasses to provide platform-specific
  /// functionality for launching a map activity. The implementation should handle
  /// invoking the appropriate platform method to perform the action.
  ///
  /// Throws an [UnimplementedError] if the method is not overridden by a subclass.
  Future<void> launchMapActivity() {
    throw UnimplementedError('launchMapActivity() has not been implemented.');
  }
}
