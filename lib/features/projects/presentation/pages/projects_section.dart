import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/projects_carusol.dart';

class Projectssection extends StatelessWidget {
  const Projectssection({super.key});

  Future<List<dynamic>> get projects async {
    // ✅ استخدم المسار الصحيح
    final jsonString = await rootBundle.loadString('assets/projects_data.json');
    final jsonMap = json.decode(jsonString);
    return jsonMap['projects'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: projects,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final projects = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                final images = project['images'] as List;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🧱 اسم المشروع
                        Text(
                          project['name'],
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),

                        // 🖼️ الصور
                        SizedBox(
                          height: 200,
                          child: ProjectsCarusol(images: images),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
