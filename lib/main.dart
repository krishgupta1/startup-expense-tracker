import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FinancialDashboardApp());
}

class FinancialDashboardApp extends StatelessWidget {
  const FinancialDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financial Dashboard',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppTheme.background,
        fontFamily: AppTheme.fontSans, // Default font
        useMaterial3: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: const DashboardScreen(),
    );
  }
}