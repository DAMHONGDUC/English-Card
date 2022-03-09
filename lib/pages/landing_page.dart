import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:english_card/pages/home_page.dart';
import 'package:english_card/values/app_asstets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'dart:io';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(children: [
          Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            color: AppColor.primaryColor,
            child: Text(
              'Welcome to',
              style: AppStyles.h3,
            ),
          )),
          Expanded(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'English',
                  style: AppStyles.h2.copyWith(
                      color: AppColor.blackGrey, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Quotes”',
                  style: AppStyles.h4.copyWith(height: 0.5),
                  textAlign: TextAlign.right,
                )
              ],
            ),
          )),
          Expanded(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Future.delayed(Duration(milliseconds: 150));
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (route) => false);
                    },
                    child: Image.asset(Assets.rightArrow),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(CircleBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white), // <-- Button color
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.red; // <-- Splash color
                      }),
                    ),
                  )))
        ]),
      ),
    );
  }
}
