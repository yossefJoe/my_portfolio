import 'dart:html' as html; // ✅ ضروري للويب
import 'package:flutter/material.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key, required this.icon, required this.link})
    : super(key: key);

  final IconData icon;
  final String link;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 🌐 يفتح الرابط في تبويب جديد على الويب
        html.window.open(link, '_blank');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white70, width: 1),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.white70, size: 22),
      ),
    );
  }
}
