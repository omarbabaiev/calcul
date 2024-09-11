import 'package:bank_calculator/constants/colors.dart';
import 'package:bank_calculator/constants/texts.dart';
import 'package:bank_calculator/constants/themes.dart';
import 'package:bank_calculator/screens/home_screen.dart';
import 'package:bank_calculator/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(CalCul());
}

class CalCul extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTexts().appTitle,
      theme: AppThemes().darkTheme,
      home: WelcomeScreen(),
    );
  }
}


