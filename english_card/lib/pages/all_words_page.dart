import 'package:english_card/models/english_todays.dart';
import 'package:english_card/values/app_asstets.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';
import 'package:flutter/material.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> words;
  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.secondColor,
        leading: InkWell(
          child: Image.asset(Assets.leftArrow),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'All Words',
          style: AppStyles.h3.copyWith(fontSize: 30, color: AppColor.textColor),
        ),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: index.floor().isEven ? AppColor.primaryColor : null,
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                height: double.infinity,
                child: Icon(
                  Icons.favorite,
                  color: words[index].isFavorite ? Colors.red : null,
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: words[index].noun.toString(),
                  style: AppStyles.h3.copyWith(
                      color: index.floor().isEven ? Colors.white : Colors.black,
                      fontSize: 25),
                  children: [
                    TextSpan(
                        text: '  (${words[index].noun_vi.toString()})',
                        style: AppStyles.h5.copyWith(color: Colors.black87)),
                  ],
                ),
              ),
              subtitle: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  words[index].quote.toString(),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
