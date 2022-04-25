import 'package:flutter/material.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/addButton.dart';
import 'package:juridoc/widgets/back_button.dart';

class SecondBarUi extends StatelessWidget {
  void Function()? func;
  String titleString;
  bool add;

  SecondBarUi(this.titleString, this.add, {this.func});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyBackButton(func: () {
            Navigator.pop(context);
          }),
          SizedBox(width: width * 0.1),
          title(),
          SizedBox(width: width * 0.1),
          (add && UserPrefs.getIsCollabOwner()) ? AddButton(func: func) : SizedBox(width: width * 0.092),
        ],
      ),
    );
  }

  Widget title() {
    return Container(
      child: Text(
        titleString,
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
