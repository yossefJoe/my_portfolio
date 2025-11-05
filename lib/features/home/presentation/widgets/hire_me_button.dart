import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class HireMeButton extends StatefulWidget {
  const HireMeButton({Key? key}) : super(key: key);

  @override
  State<HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<HireMeButton> {
  Map<String, dynamic>? _profileData;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final jsonString = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/cv_info.json');
    setState(() {
      _profileData = json.decode(jsonString);
    });
  }

  Future<void> _openWhatsApp() async {
    String phoneNumber = _profileData?['phone_number'];
    final webUrl = 'https://wa.me/$phoneNumber';
    final mobileUrl = Uri.parse('whatsapp://send?phone=$phoneNumber');
    print(phoneNumber);
    print(webUrl);
    print(mobileUrl);
    if (kIsWeb) {
      // 🖥️ لو ويب — يفتح في واتساب ويب
      final anchor = html.AnchorElement(href: webUrl)..target = '_blank';
      anchor.click();
    } else {
      // 📱 لو موبايل — يفتح تطبيق واتساب
      if (await canLaunchUrl(mobileUrl)) {
        await launchUrl(mobileUrl);
      } else {
        // fallback يفتح رابط واتساب ويب لو التطبيق مش متثبت
        final fallbackUrl = Uri.parse(webUrl);
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: _openWhatsApp,
      child: const Text("Hire Me", style: TextStyle(color: Colors.white)),
    );
  }
}
