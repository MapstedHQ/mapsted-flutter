// ignore_for_file: avoid_print

/// A library for setting up Mapsted configuration files for a Flutter project.
///
/// This library provides functionality for configuring Mapsted-related settings
/// for both iOS and Android platforms within a Flutter project. It includes
/// utility functions for applying permissions, themes, and other configuration
/// details needed for integrating Mapsted into the project.
///
/// This library is intended to be used as part of the command-line interface (CLI)
/// for automating the setup process for Mapsted.
library mapsted_flutter_cli;

import 'dart:io';

import 'package:plist_parser/plist_parser.dart';

part 'ios.dart'; // Contains iOS-specific configuration functions
part 'android.dart'; // Contains Android-specific configuration functions
part 'templates.dart'; // Contains template definitions for configuration files
part 'constant.dart'; // Contains constants used across configuration files

/// Creates the Mapsted configuration files.
///
/// This function prints a setup message to the console and then initiates the
/// process of creating and configuring various Mapsted-related script files
/// required for both iOS and Android platforms. It handles tasks such as
/// applying permissions, setting themes, and updating deployment targets.
///
/// Example usage:
/// ```dart
/// createMapConfig();
/// ```
void createMapConfig() {
  print(
    '''
╔════════════════════════════════════════════════════════════════════════════╗
║                             Setting up Map Config!                         ║
╚════════════════════════════════════════════════════════════════════════════╝
''',
  );

  _createScriptFiles();
}

/// Creates and updates various script files for Mapsted configuration.
///
/// This private function performs a series of file updates and modifications
/// necessary for configuring Mapsted. It applies permissions, themes, and other
/// settings for both iOS and Android platforms.
///
/// - Applies permissions to the Android manifest file.
/// - Applies theme settings to the Android manifest file.
/// - Applies iOS permissions to the `Info.plist` file.
/// - Updates the `Podfile` with necessary sources and deployment target.
///
/// This function is intended to be called internally by the [createMapConfig]
/// function to handle the setup process.
void _createScriptFiles() {
  // Detect the Android project layout: modern Flutter uses Kotlin-DSL (build.gradle.kts),
  // older projects use Groovy (build.gradle). The 26.7.1 manifest placeholders must be
  // injected either way, in the correct syntax — otherwise the AAR manifest merge fails.
  final bool useKts = File(appGradleKts).existsSync();

  _createGradleTemplate(file: repositoriesPath, template: _repositoriesGradle);
  _createGradleTemplate(file: buildExtrasGradle, template: _buildExtrasGradle);

  if (useKts) {
    // Kotlin-DSL: SDK repos resolve via the plugin; only the manifest placeholders need
    // injecting, in KTS syntax. The Groovy buildscript/allprojects blocks do not apply here.
    final now = DateTime.now();
    final dateString = '${now.year}${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}';
    _applyExtraGradle(
        path: appGradleKts, template: extraGradleApplyKts(dateString));
  } else {
    _applyRepositoryIntoGradle(path: androidGradle, template: _buildScriptBloc);
    _applyProjectInGradle(path: androidGradle, template: _allProjectBloc);
    _applyExtraGradle(path: appGradle, template: _extraGradleApply);
  }

  _applyPermission(path: mainifestFile, permissions: _permissionList);
  _aplyTheme(path: mainifestFile, theme: _themeStyle);
  _applyIosPermission(path: infoFile, permissions: _iosPermissionList);
  _applyPodfileSource(path: podfile, sources: _iosSource);
  _updateDeploymentTarget(path: podfile, version: _iosMinVersion);
}
