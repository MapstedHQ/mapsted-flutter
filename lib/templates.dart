part of 'cli_commands.dart';

const _iosMinVersion = 16.0;

const String _repositoriesGradle = '''
/* Licensed to the Apache Software Foundation (ASF) under one
   or more contributor license agreements.  See the NOTICE file
   distributed with this work for additional information
   regarding copyright ownership.  The ASF licenses this file
   to you under the Apache License, Version 2.0 (the
   "License"); you may not use this file except in compliance
   with the License.  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing,
   software distributed under the License is distributed on an
   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
   KIND, either express or implied.  See the License for the
   specific language governing permissions and limitations
   under the License.
*/

ext.repos = {
    google()
    mavenCentral()
	  maven { url "https://mapstedhq.github.io/mapsted-android-maven" }
}
''';

const String _buildExtrasGradle = '''
android {
    // Add your custom configurations here
    defaultConfig {
        // Required by the Mapsted SDK 26.7.1 AAR meta-data (manifest placeholders).
        manifestPlaceholders += [versionCode: "1", dateString: new Date().format('yyyyMMdd')]
    }
    packagingOptions {
                        exclude 'META-INF/LICENSE.md'
                        exclude 'META-INF/NOTICE.md'
                        exclude 'META-INF/gradle/incremental.annotation.processors'
                    }
    dataBinding {
        enabled = true
    }
}
''';

const String _buildScriptBloc = '''
buildscript {
    apply from: 'repositories.gradle'
    repositories repos
}
''';

const String _allProjectBloc = '''
allprojects {
    def hasRepositoriesGradle = file('repositories.gradle').exists()
    if (hasRepositoriesGradle) {
        apply from: 'repositories.gradle'
    } else {
        apply from: "\${project.rootDir}/repositories.gradle"
    }

    repositories repos
}
''';

const String _extraGradleApply = '''
def hasBuildExtras1 = file('build-extras.gradle').exists()
if (hasBuildExtras1) {
    apply from: 'build-extras.gradle'
}
''';

const String _themeStyle = '''
<activity android:name="com.mapsted.ui.map.MapstedMapActivity" android:theme="@style/AppTheme" />
''';

const List<String> _permissionList = [
  '<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />',
  '<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />',
];

const List<Map<String, String>> _iosPermissionList = [
  {
    "key": "NSMotionUsageDescription",
    "string": "Your motion description goes here",
  },
  {
    "key": "NSLocationAlwaysUsageDescription",
    "string": "Your location description goes here",
  },
  {
    "key": "NSLocationWhenInUseUsageDescription",
    "string": "Your location description goes here",
  },
];

List<String> _iosSource = [
  "source 'https://cdn.cocoapods.org/'",
  "source 'https://github.com/MapstedHQ/podspec.git'",
];
