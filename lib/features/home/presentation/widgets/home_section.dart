import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/utils/responsive.dart';
import 'download_button.dart';
import 'hire_me_button.dart';
import 'social_media.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
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

  @override
  Widget build(BuildContext context) {
    if (_profileData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final name = _profileData!['name'];
    final title = _profileData!['title'];
    final image = 'assets/developer_pic.png';
    final social = _profileData!['social_links'];
    final cv = _profileData!['cv_path'];

    return Container(
      color: const Color(0xFF121212),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal:
            Responsive.isDesktop(context)
                ? 120
                : Responsive.isTablet(context)
                ? 60
                : 20,
        vertical: Responsive.isMobile(context) ? 40 : 80,
      ),
      child:
          Responsive.isMobile(context)
              ? SingleChildScrollView(
                child: _buildColumnLayout(
                  context,
                  name,
                  title,
                  image,
                  social,
                  cv,
                ),
              )
              : SingleChildScrollView(
                child: _buildRowLayout(context, name, title, image, social, cv),
              ),
    );
  }

  Widget _buildRowLayout(
    BuildContext context,
    String name,
    String title,
    String image,
    Map social,
    String cv,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: _buildIntroSection(context, name, title, social, cv),
        ),
        const SizedBox(width: 40),
        CircleAvatar(
          radius: 250.r,
          backgroundColor: Colors.grey[800],
          backgroundImage: AssetImage(image),
          // foregroundImage: AssetImage(image, ),
        ),
      ],
    );
  }

  Widget _buildColumnLayout(
    BuildContext context,
    String name,
    String title,
    String image,
    Map social,
    String cv,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 100,
          backgroundColor: Colors.grey[800],
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(height: 30),
        _buildIntroSection(context, name, title, social, cv),
      ],
    );
  }

  Widget _buildIntroSection(
    BuildContext context,
    String name,
    String title,
    Map social,
    String cv,
  ) {
    final primary = Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, I am",
          style: TextStyle(
            color: Colors.white70,
            fontSize: Responsive.isDesktop(context) ? 22 : 18,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: Responsive.isDesktop(context) ? 32 : 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: primary,
            fontWeight: FontWeight.bold,
            fontSize: Responsive.isDesktop(context) ? 48 : 28,
          ),
        ),
        const SizedBox(height: 24),

        // 🌐 Social Icons
        Row(
          children: [
            SocialMedia(
              icon: FontAwesomeIcons.linkedin,
              link: social['linkedin'],
            ),
            const SizedBox(width: 16),
            SocialMedia(
              icon: FontAwesomeIcons.facebook,
              link: social['facebook'],
            ),
            const SizedBox(width: 16),
            SocialMedia(
              icon: FontAwesomeIcons.instagram,
              link: social['instagram'],
            ),
            const SizedBox(width: 16),
            SocialMedia(icon: FontAwesomeIcons.github, link: social['github']),
          ],
        ),
        const SizedBox(height: 30),

        Wrap(
          children: [
            HireMeButton(),
            const SizedBox(width: 16),
            DownloadCVButton(),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
