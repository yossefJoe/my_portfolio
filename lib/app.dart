import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/utils/theme_manager.dart';
import 'features/home/presentation/tabview/portfolio_tabs_view.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        1440,
        1024,
      ), // مقاسات ديسكتوب افتراضية (ممكن تغيرها)
      minTextAdapt: true,
      splitScreenMode: true,
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Youssef Mahmoud Portfolio',
            debugShowCheckedModeBanner: false,
            theme: themeManager.currentTheme,
            home: PortfolioTabsView(),
          );
        },
      ),
    );
  }
}
