import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color background = Colors.black;
  static const Color cardDark = Color(0xFF161616);
  static const Color accentWhite = Colors.white;
  static const Color textGrey = Color(0xFF888888);

  // Brand Colors
  static const Color greenSafe = Color(0xFF00BFA5);
  static const Color yellowWarning = Color(0xFFFFA000);
  static const Color redCritical = Color(0xFFFF4081);
  static const Color credBlue = Color(0xFF3A4B8A);

  // Fonts
  static const String fontSerif =
      'Times New Roman'; // Represents a Classy Serif
  static const String fontSans = 'Roboto'; // Represents a Clean Sans-Serif

  // Text Styles
  static TextStyle headerStyle = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: accentWhite,
    letterSpacing: 0.5,
  );

  static TextStyle sectionTitleStyle = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: textGrey,
    letterSpacing: 1.5,
  );

  static TextStyle bodyStyle = GoogleFonts.inter(
    fontSize: 14,
    color: accentWhite,
  );
}
