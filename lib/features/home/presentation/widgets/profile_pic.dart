import 'package:flutter/material.dart';

class ProfileAvatarSection extends StatelessWidget {
  final String image;

  const ProfileAvatarSection({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // عشان الصورة تطلع برا الستاك
      alignment: Alignment.topCenter,
      children: [
        // الكارت أو الخلفية
        Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.only(top: 100), // يسيب مساحة فوق للصورة
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            shape: BoxShape.circle,
          ),
        ),

        // الصورة الطالعة لفوق
        Positioned(
          top: -60, // المسافة اللي الصورة طالعة بيها لفوق
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey[800],
            backgroundImage: AssetImage(image),
          ),
        ),
      ],
    );
  }
}
