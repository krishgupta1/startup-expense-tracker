import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:startup_expense_tracker/features/auth/screen/signup.dart';
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
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      home: const SignUpScreen(),
    );
  }
}
