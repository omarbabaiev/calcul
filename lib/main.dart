import 'package:bank_calculator/constants/colors.dart';
import 'package:bank_calculator/constants/texts.dart';
import 'package:bank_calculator/constants/themes.dart';
import 'package:bank_calculator/screens/home_screen.dart';
import 'package:bank_calculator/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor().scaffColor,
    statusBarColor: AppColor().scaffColor, // Set to any color you like
    statusBarIconBrightness: Brightness.light, // White status bar icons
  ));
  FlutterNativeSplash.remove();
  runApp(CalCul());
}

class CalCul extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTexts().appTitle,
      theme: AppThemes().darkTheme,
      home: box.read("intro") != null ? HomeScreen() : WelcomeScreen(),
    );
  }
}


