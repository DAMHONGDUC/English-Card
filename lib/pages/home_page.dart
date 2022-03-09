import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:english_card/packages/quote/quote.dart';
import 'package:english_card/packages/quote/quote_model.dart';
import 'package:english_card/pages/control_page.dart';
import 'package:english_card/values/app_asstets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:english_card/values/share_keys.dart';
import 'package:english_card/widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:english_card/models/english_todays.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currIndex = 0;

  late PageController _pageController;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<EnglishToday> words = [];
  String quoteHeader = Quotes().getRandom().getContent()!;

  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) return [];

    List<int> newList = [];
    Random random = Random();
    int count = 1;

    while (count <= len) {
      int a = random.nextInt(max);
      if (newList.contains(a))
        continue;
      else {
        newList.add(a);
        count++;
      }
    }
    return newList;
  }

  void getEnglishToday() async {
    final prefs = await SharedPreferences.getInstance();

    int len = prefs.getInt(ShareKeys.slidevalue) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedListRandom(len: len, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });

    setState(() {
      words = newList.map((e) => getQuote(e)).toList();
    });
  }

  EnglishToday getQuote(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    if (quote == null) quote = Quotes().getRandom();
    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
      author: quote?.author,
    );
  }

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _globalKey,
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondColor,
        elevation: 0,
        title: Text(
          'English today',
          style: AppStyles.h3.copyWith(fontSize: 30, color: AppColor.textColor),
        ),
        leading: InkWell(
          child: Image.asset(Assets.menu),
          onTap: () {
            _globalKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColor.lighBlue,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your mind',
                  style: AppStyles.h3
                      .copyWith(color: AppColor.textColor, fontSize: 30),
                ),
                AppButton(
                  label: 'Favorites',
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: AppButton(
                    label: 'Your control',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ControlPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(children: [
        Container(
          height: size.height * 1.2 / 10,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            '“$quoteHeader”',
            style:
                AppStyles.h5.copyWith(color: AppColor.textColor, fontSize: 14),
          ),
        ),
        Container(
          height: size.height * 3 / 5,
          child: PageView.builder(
            itemCount: words.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currIndex = index;
              });
            },
            itemBuilder: (context, index) {
              String noun = words[index].noun == null ? '' : words[index].noun!;
              String firstletter = noun.substring(0, 1);
              String remainingLetters = noun.substring(1, noun.length);
              String defaultQuote =
                  'Think of all the beauty still left around you and be happy.';
              String quote = words[index].quote == null
                  ? defaultQuote
                  : words[index].quote!;
              String quoteAuthor =
                  words[index].author == null ? '' : words[index].author!;
              int stt = index + 1;

              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Text(
                                    '$stt',
                                    style: AppStyles.h5.copyWith(
                                        color: AppColor.textColor,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(Assets.heart)),
                              ),
                            ],
                          )),
                          RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: firstletter,
                                  style: AppStyles.h1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          offset: Offset(3, 6),
                                          blurRadius: 6,
                                        )
                                      ]),
                                  children: [
                                    TextSpan(
                                      text: remainingLetters,
                                      style: AppStyles.h3.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 55),
                                    )
                                  ])),
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: Text(
                              '"$quote"',
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.h4.copyWith(letterSpacing: 1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  '― $quoteAuthor',
                                  style: AppStyles.h5
                                      .copyWith(color: AppColor.textColor),
                                )),
                          ),
                        ]),
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ));
            },
          ),
        ),
        // _currIndex >= 5
        //     ? buildShowmore()
        //     :
        Padding(
          padding: const EdgeInsets.all(25),
          child: Container(
            height: 12,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return buildIndicator(
                      index == _currIndex ? true : false, size);
                }),
          ),
        ),
      ]),
      floatingActionButton: Container(
        height: size.height * 1 / 10,
        child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 223, 65, 118),
            child: Image.asset(Assets.exchange),
            onPressed: () {
              setState(() {
                getEnglishToday();
              });
            }),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 14,
      width: isActive ? size.width * 1 / 5 : 25,
      decoration: BoxDecoration(
          color: isActive ? AppColor.lighBlue : AppColor.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(2, 3),
              blurRadius: 3,
            )
          ]),
    );
  }

  // Widget buildShowmore() {
  //   return Container(
  //     color: Colors.pink,
  //     child: Text('Show more'),
  //   );
  // }
}
