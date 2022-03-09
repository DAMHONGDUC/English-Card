import 'package:flutter/material.dart';
import 'package:english_card/values/app_colors.dart';
import 'package:english_card/values/app_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(3, 6)),
            ]),
        alignment: Alignment.centerLeft,
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            label,
            style: AppStyles.h3.copyWith(
                color: AppColor.textColor,
                fontWeight: FontWeight.normal,
                fontSize: 15),
          ),
        ),
      ),
    );
  }
}
