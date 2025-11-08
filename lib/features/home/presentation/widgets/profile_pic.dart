import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/responsive.dart';

class ProfileAvatarSection extends StatelessWidget {
  final String image;

  const ProfileAvatarSection({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد الحجم حسب نوع الجهاز
    final double size =
        Responsive.isDesktop(context)
            ? 450.w
            : Responsive.isTablet(context)
            ? 450.w
            : 600.w; // أصغر للأجهزة الصغيرة

    return Container(
      width: size,
      height: size, // خلي العرض والارتفاع متساويين عشان تبقى دائرية

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.contain, // يغطي كل الدائرة بدون تشويه
          filterQuality: FilterQuality.high,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
    );
  }
}
