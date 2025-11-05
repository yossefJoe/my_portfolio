import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDark = true;
  int _colorIndex = 0;

  final List<Color> _primaryColors = [Colors.blue];

  ThemeData get currentTheme => ThemeData(
    brightness: _isDark ? Brightness.dark : Brightness.light,
    primaryColor: _primaryColors[_colorIndex],
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColors[_colorIndex],
      brightness: _isDark ? Brightness.dark : Brightness.light,
    ),
    scaffoldBackgroundColor: _isDark ? const Color(0xFF1C1C1C) : Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: _isDark ? const Color(0xFF1C1C1C) : Colors.white,
      elevation: 0,
    ),
  );

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void nextColor() {
    _colorIndex = (_colorIndex + 1) % _primaryColors.length;
    notifyListeners();
  }
}
