import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/utils/theme_manager.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(),
      child: const PortfolioApp(),
    ),
  );
}
