import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:english_card/pages/home_page.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:english_card/values/app_asstets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:english_card/values/share_keys.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  _ControlPageState createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double slidevalue = 5;
  late SharedPreferences prefs;

  @override
  void initState() {
    innitDefault_slidevalue();
    super.initState();
  }

  void innitDefault_slidevalue() async {
    prefs = await SharedPreferences.getInstance();
    int slidevalue_before = prefs.getInt(ShareKeys.slidevalue) ?? 5;
    setState(() {
      slidevalue = slidevalue_before.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondColor,
        elevation: 0,
        title: Text(
          'Your control',
          style: AppStyles.h3.copyWith(fontSize: 30, color: AppColor.textColor),
        ),
        leading: InkWell(
            child: Image.asset(
              Assets.leftArrow,
            ),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                height: size.height * 1 / 9,
                child: Text(
                  'How much a number word at once?',
                  style: AppStyles.h5
                      .copyWith(color: AppColor.greyText, fontSize: 17),
                )),
            Container(
                alignment: Alignment.center,
                height: size.height * 3 / 9,
                child: Text(
                  '${slidevalue.toInt()}',
                  style: AppStyles.h1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                      fontSize: 150),
                )),
            Container(
              alignment: Alignment.centerLeft,
              child: Slider(
                  activeColor: AppColor.primaryColor,
                  inactiveColor: AppColor.primaryColor,
                  value: slidevalue,
                  min: 5,
                  max: 100,
                  divisions: 100,
                  onChanged: (value) {
                    setState(() {
                      slidevalue = value;
                    });
                  }),
            ),
            Container(
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                height: size.height * 0.7 / 9,
                child: Text(
                  'Slide to set',
                  style: AppStyles.h5.copyWith(color: AppColor.textColor),
                )),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setInt(
                        ShareKeys.slidevalue, slidevalue.toInt());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
