import 'package:english_card/models/english_todays.dart';
import 'package:flutter/material.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_asstets.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FavoritesPage extends StatelessWidget {
  final List<EnglishToday> words;
  const FavoritesPage({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondColor,
        elevation: 0,
        leading: InkWell(
          child: Image.asset(Assets.leftArrow),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Favorites',
          style: AppStyles.h3.copyWith(fontSize: 30, color: AppColor.textColor),
        ),
      ),
      body: Container(
          child: GridView.count(
        physics: ScrollPhysics(),
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: words
            .map((e) => Container(
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      e.noun ?? 'Loading...',
                      style: AppStyles.h4.copyWith(shadows: [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(3, 6),
                            blurRadius: 6)
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        '(${e.noun_vi})' ?? '(Loading...)',
                        style: AppStyles.h4
                            .copyWith(color: AppColor.textColor, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )))
            .toList(),
      )),
    );
  }
}
