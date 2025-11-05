import 'dart:convert';
import 'dart:io';

void main() async {
  final assetsDir = Directory('assets/projectsScreens');
  if (!await assetsDir.exists()) {
    print('⚠️ Directory not found: ${assetsDir.path}');
    return;
  }

  final projects = <Map<String, dynamic>>[];

  await for (var entity in assetsDir.list(
    recursive: false,
    followLinks: false,
  )) {
    if (entity is Directory) {
      final folderName = entity.path.split(Platform.pathSeparator).last;
      final projectName = _splitCamelCase(folderName); // 🪄 هنا التعديل

      final images = <String>[];

      await for (var file in entity.list(
        recursive: false,
        followLinks: false,
      )) {
        if (file is File && _isImage(file.path)) {
          final normalizedPath = file.path.replaceAll('\\', '/');
          // ✅ إزالة "assets/" من بداية المسار فقط
          images.add(normalizedPath.replaceFirst('assets/', ''));
        }
      }

      if (images.isNotEmpty) {
        projects.add({'name': projectName, 'images': images});
        print('📁 Project found: $projectName (${images.length} images)');
      } else {
        print('⚠️ No images found in: $projectName');
      }
    }
  }

  if (projects.isEmpty) {
    print('⚠️ No projects found inside ${assetsDir.path}');
    return;
  }

  final jsonMap = {'projects': projects};
  final output = JsonEncoder.withIndent('  ').convert(jsonMap);

  final outputFile = File('assets/projects_data.json');
  await outputFile.writeAsString(output);

  print('\n✅ JSON generated successfully at ${outputFile.path}');
}

bool _isImage(String path) {
  final lower = path.toLowerCase();
  return lower.endsWith('.png') ||
      lower.endsWith('.jpg') ||
      lower.endsWith('.jpeg') ||
      lower.endsWith('.webp');
}

/// 🧠 دالة لتحويل اسم المشروع من CamelCase إلى اسم طبيعي بمسافات
String _splitCamelCase(String text) {
  final result = text.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  );
  // نخلي أول حرف كبير
  return result[0].toUpperCase() + result.substring(1);
}
