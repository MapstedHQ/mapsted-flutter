import 'package:flutter_test/flutter_test.dart';
import 'package:mapsted_flutter/mapsted_flutter.dart';
import 'package:mapsted_flutter/mapsted_flutter_platform_interface.dart';
import 'package:mapsted_flutter/mapsted_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMapstedFlutterPlatform
    with MockPlatformInterfaceMixin
    implements MapstedFlutterPlatform {


  @override
  Future<void> launchMapActivity() async=> Future.value();
}

void main() {
  final MapstedFlutterPlatform initialPlatform = MapstedFlutterPlatform.instance;

  test('$MethodChannelMapstedFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMapstedFlutter>());
  });

  test('launchMapActivity', () async {
    MapstedFlutter mapstedFlutterPlugin = MapstedFlutter();
    MockMapstedFlutterPlatform fakePlatform = MockMapstedFlutterPlatform();
    MapstedFlutterPlatform.instance = fakePlatform;
    mapstedFlutterPlugin.launchMapActivity();  
  });
}
