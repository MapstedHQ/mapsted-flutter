part of 'cli_commands.dart';

void _createGradleTemplate({
  required String file,
  required String template,
}) {
  final gradleFile = File(file);
  print('[Android]  - $file');
  if (!gradleFile.existsSync()) {
    print('[Android] No $file found in your Android project');
    print('[Android] Creating $file and adding it to your Android project');
    gradleFile.createSync(recursive: true);
    gradleFile.writeAsStringSync(template);
  } else {
    String content = gradleFile.readAsStringSync();
    List<String> missingLines = [];
    List<String> templateLines = template.split('\n');

    for (String line in templateLines) {
      if (!content.contains(line.trim())) {
        missingLines.add(line.trim());
      }
    }

    if (missingLines.isNotEmpty) {
      print(
          '[Android] $file found but some sections are missing. Adding missing sections.');
      gradleFile.writeAsStringSync('\n${missingLines.join('\n')}',
          mode: FileMode.append);
    } else {
      print(
          '[Android] $file already contains the full template. No changes needed.');
    }
  }
}

void _applyRepositoryIntoGradle(
    {required String path, required String template}) {
  // Read the file
  final file = File(path);
  if (!file.existsSync()) {
    print('Error: $path does not exist.');
    return;
  }

  final content = file.readAsStringSync();

  final buildscriptRegex = RegExp(
    r'buildscript\s*\{(?:[^{}]|\{[^{}]*\})*\}\s*',
    multiLine: true,
    dotAll: true,
  );

  String contentWithoutBuildscript =
      content.replaceAll(buildscriptRegex, '').trim();

  final finalContent = '$template\n\n$contentWithoutBuildscript';

  file.writeAsStringSync(finalContent);
  print('build.gradle file updated successfully.');
}

void _applyProjectInGradle({required String path, required String template}) {
  final file = File(path);
  if (!file.existsSync()) {
    print('Error: $path does not exist.');
    return;
  }

  final content = file.readAsStringSync();

  final regExp =
      RegExp(r'allprojects\s*\{[^}]*\}', multiLine: true, dotAll: true);

  String contentWithoutAllProject = content.replaceAll(regExp, '').trim();

  print(contentWithoutAllProject);
}

void _applyExtraGradle({required String path, required String template}) {
  final file = File(path);
  if (!file.existsSync()) {
    print('Error: $path does not exist.');
    return;
  }

  String content = file.readAsStringSync();

  if (content.contains(template.trim())) {
    print('The block is already present.');
  } else {
    content += '\n$template';
    file.writeAsString(content);
    print('The block has been added.');
  }
}

void _applyPermission(
    {required String path, required List<String> permissions}) {
  try {
    print('[Android]  - $path');
    final manifestContent = File(path);

    String updatedConent = manifestContent.readAsStringSync();

    for (String element in permissions) {
      if (!updatedConent.contains(element)) {
        updatedConent = updatedConent.replaceAll(
          '</manifest>',
          '\t$element\n</manifest>',
        );
      }
    }

    manifestContent.writeAsStringSync(updatedConent);
    print("Android permission added into $path");
  } catch (e) {
    print("add permission error :${e.toString()}");
  }
}

void _aplyTheme({required String path, required String theme}) {
  try {
    print('[Android]  - $path');
    final manifestContent = File(path);

    String updatedConent = manifestContent.readAsStringSync();

    if (!updatedConent.contains(theme)) {
      updatedConent = updatedConent.replaceAll(
        '</application>',
        '\t$theme\n</application>',
      );
    } else {
      print("theme is already apply");
    }
    manifestContent.writeAsStringSync(updatedConent);
    print("theme added into $path");
  } catch (e) {
    print("add permission error :${e.toString()}");
  }
}
