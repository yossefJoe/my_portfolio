import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'Flutter', 'percent': 1.0},
      {'name': 'Dart', 'percent': 1.0},
      {'name': 'Git / GitHub', 'percent': 1.0},
      {'name': 'UI Implementation', 'percent': 1.0},
      {'name': 'Firebase', 'percent': 1},
      {'name': 'REST APIs', 'percent': 1},
      {'name': 'Bloc & MVVM', 'percent': 1},
      {'name': 'Clean Architecture', 'percent': 1},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Me",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "I’m a Flutter Developer with 2 years of experience. "
              "I’ve worked full-time, part-time, onsite, remotely, and on multiple freelance projects. "
              "Throughout my journey, I’ve built numerous apps with clean, reusable, and maintainable code — "
              "focusing on scalability, performance, and pixel-perfect UI implementation. "
              "I always deliver exactly what’s required, ensuring every design is implemented precisely as intended. "
              "I also provide ongoing support, follow up on projects continuously, "
              "and ensure fast, efficient execution from start to finish.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 40,
              runSpacing: 40,
              children:
                  skills.map((skill) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularPercentIndicator(
                          radius: 45,
                          lineWidth: 8,
                          percent: skill['percent'] as double,
                          animation: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          backgroundColor: Colors.grey.shade800,
                          progressColor: Colors.blueAccent,
                          center: Text(
                            "${((skill['percent'] as double) * 100).toInt()}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          skill['name'] as String,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
