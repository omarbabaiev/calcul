import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';



class AppThemes{
  final darkTheme = ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, scrolledUnderElevation: 0, ),
      colorScheme: ColorScheme.fromSeed(primary: AppColor().orangeColor, seedColor: AppColor().orangeColor, onTertiaryContainer: AppColor().orangeColor ),
      textTheme: GoogleFonts.latoTextTheme().copyWith(
      displayLarge: GoogleFonts.openSans(fontSize: 40.0, fontWeight: FontWeight.w600, color: Colors.white),
      displayMedium: GoogleFonts.openSans(fontSize: 25.0, fontWeight: FontWeight.w500, color: Colors.white),
      titleMedium: GoogleFonts.openSans(fontSize: 16.0, color: Colors.white54),
      titleLarge: GoogleFonts.openSans(fontSize: 20.0, color: Colors.white),

    ),
    scaffoldBackgroundColor: AppColor().scaffColor,
    useMaterial3: true,);
}