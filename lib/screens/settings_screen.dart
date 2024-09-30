import 'package:bank_calculator/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/texts.dart';
import 'home_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          }, icon: Icon(Icons.close, color: AppColor().orangeAccentColor,),
        ),
          title: Text(AppTexts().settingsScreenTitle, style: Theme.of(context).textTheme.titleLarge),
        actions: [
         ]),
      body: Center(
        child: Column(
          children: [
            Text('This is the Settings Screen'),
          ],
        ),
      ),
    );
  }
}
