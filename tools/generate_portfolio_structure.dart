import 'dart:io';

void main() async {
  final base = Directory('lib');
  final structure = {
    'core/constants': [
      'app_colors.dart',
      'app_assets.dart',
      'app_text_styles.dart',
    ],
    'core/widgets': [
      'primary_button.dart',
      'custom_text.dart',
      'section_title.dart',
    ],
    'core/utils': ['responsive.dart'],
    'features/home/presentation/widgets': [
      'about_section.dart',
      'projects_section.dart',
      'contact_section.dart',
      'skills_section.dart',
    ],
    'features/home/data': ['projects_data.dart'],
  };

  // إنشاء المجلدات والملفات
  for (final entry in structure.entries) {
    final dir = Directory('${base.path}/${entry.key}');
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print('✅ Created folder: ${dir.path}');
    }

    for (final file in entry.value) {
      final filePath = '${dir.path}/$file';
      final f = File(filePath);
      if (!f.existsSync()) {
        f.writeAsStringSync(_fileContent(entry.key, file));
        print('📄 Created file: $filePath');
      }
    }
  }

  // إنشاء ملفات الأساس
  final mainFile = File('lib/main.dart');
  if (!mainFile.existsSync()) {
    mainFile.writeAsStringSync(_mainFileContent());
    print('🚀 Created main.dart');
  }

  final appFile = File('lib/app.dart');
  if (!appFile.existsSync()) {
    appFile.writeAsStringSync(_appFileContent());
    print('🚀 Created app.dart');
  }

  print('\n🎉 Portfolio structure generated successfully!');
}

String _fileContent(String folder, String fileName) {
  // محتوى مبدئي بسيط حسب نوع الملف
  if (fileName == 'responsive.dart') {
    return '''
import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1100;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
}
''';
  }

  if (folder.contains('presentation/widgets')) {
    final className =
        fileName.split('.').first.replaceAll('_', '').replaceFirstMapped(RegExp(r'^\w'), (m) => m.group(0)!.toUpperCase());
    return '''
import 'package:flutter/material.dart';

class ${className} extends StatelessWidget {
  const ${className}({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$className section'));
  }
}
''';
  }

  return '// $fileName';
}

String _mainFileContent() => '''
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const PortfolioApp());
}
''';

String _appFileContent() => '''
import 'package:flutter/material.dart';
import 'features/home/presentation/widgets/about_section.dart';
import 'features/home/presentation/widgets/projects_section.dart';
import 'features/home/presentation/widgets/contact_section.dart';
import 'features/home/presentation/widgets/skills_section.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AboutSection(),
              SkillsSection(),
              ProjectsSection(),
              ContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}
''';
