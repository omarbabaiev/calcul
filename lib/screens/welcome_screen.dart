import 'package:bank_calculator/constants/assets.dart';
import 'package:bank_calculator/constants/colors.dart';
import 'package:bank_calculator/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets().welcome, height: Get.height/1.9,),
              SizedBox(height: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("CalCul", style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColor().orangeColor ), textAlign: TextAlign.start, ),
                  SizedBox(height: 5,),
                  Text("Your Smart Finance Assistant", style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.start,),
                  SizedBox(height: 10,),
                  Text("Calculate loan interests, manage currencies, and handle financial operations effortlessly.",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(wordSpacing: 1, height: 1.6), textAlign: TextAlign.start, ),
                  SizedBox(height: 70),
                  SliderButton(
                    boxShadow: BoxShadow(color: Colors.white70, blurRadius: 5),
                    buttonSize: 50,
                    height: 60,
                    width: 240,
                    buttonColor: AppColor().orangeColor,
                    backgroundColor: Theme.of(context).cardColor,
                    action: () async {
                      Get.offAll(()=> HomeScreen(), transition: Transition.cupertino);
                      HapticFeedback.selectionClick();
                    },
                    label: Center(
                      child: Text(
                        "Get started",
                        style: TextStyle(
                            color: Color(0xff4a4a4a),
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                      ),
                    ),
                    icon: Center(
                        child: Icon(
                          CupertinoIcons.chevron_right,
                          color: Theme.of(context).textTheme.displayLarge!.color,
                          size: 30.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        )),
                  ),

                ],
              ),





            ],
          ),
        ),
      ),

    );
  }
}

