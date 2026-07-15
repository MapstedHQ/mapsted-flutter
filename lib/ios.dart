// ignore_for_file: avoid_print
part of 'cli_commands.dart';

void _applyIosPermission(
    {required String path, required List<Map<String, String>> permissions}) {
  try {
    final infoContent = File(path);

    String updatedConent = infoContent.readAsStringSync();

    var result = PlistParser().parse(updatedConent);

    for (Map<String, String> k in permissions) {
      if (!result.keys.contains(k["key"] ?? "")) {
        updatedConent = updatedConent.replaceAll(
          '<dict>',
          '<dict>\n\t<key>${k['key']}</key>\n\t<string>${k['string']}</string>',
        );
      } else {
        print("${k["key"]} permission is already there");
      }
    }

    infoContent.writeAsStringSync(updatedConent);
    print("theme added into $path");
  } catch (e) {
    print("add permission error :${e.toString()}");
  }
}

void _applyPodfileSource(
    {required String path, required List<String> sources}) {
  try {
    final infoContent = File(path);
    if (infoContent.existsSync()) {
      String updatedConent = infoContent.readAsStringSync();
      for (String k in sources) {
        String test = _uncommentLine(updatedConent, k);
        updatedConent = test;
        if (!updatedConent.contains(k)) {
          updatedConent = "$k\n$updatedConent";
        }
      }
      infoContent.writeAsStringSync(updatedConent);
    } else {
      print("$path file is not exist");
    }
  } catch (e) {
    print("add permission error :${e.toString()}");
  }
}

void _updateDeploymentTarget({required String path, required double version}) {
  try {
    final infoContent = File(path);
    if (infoContent.existsSync()) {
      String rVersion = "platform :ios, '$version'";
      String updatedConent = infoContent.readAsStringSync();
      updatedConent = _uncommentLine(updatedConent, "platform :ios,");

      RegExp regExp = RegExp(r"platform\s*:\s*ios,\s*'(\d+\.\d+)'");
      final match = regExp.firstMatch(updatedConent);
      if (match != null) {
        double currentVersion = double.tryParse(match.group(1) ?? "") ?? 0;
        if (currentVersion < version) {
          updatedConent = updatedConent.replaceAll(
              "platform :ios, '$currentVersion'", rVersion);
        }
      } else {
        updatedConent = "$rVersion\n$updatedConent";
      }
      infoContent.writeAsStringSync(updatedConent);
    } else {
      print("$path file is not exist");
    }
  } catch (e) {
    print("deployment target change error:$e");
  }
}

String _uncommentLine(String content, String lineToUncomment) {
  final lines = content.split('\n');
  final updatedLines = lines.map((line) {
    final trimmedLine = line.trim();
    if (trimmedLine.startsWith('#') && trimmedLine.contains(lineToUncomment)) {
      return line.substring(1).trim(); // Remove the leading '#'
    }
    return line;
  }).toList();
  return updatedLines.join('\n');
}
