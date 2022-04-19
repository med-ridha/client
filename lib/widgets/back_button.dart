import 'package:flutter/material.dart';
import 'package:juridoc/theme.dart';

class MyBackButton extends StatelessWidget {
  void Function()? func;

  MyBackButton({this.func});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          color: kPrimaryColor
        ),
        child: IconButton(
        padding: EdgeInsets.zero,
            color: Colors.white,
            onPressed: func,
            icon: Icon(Icons.arrow_back_ios_sharp, size: 40)),
      ),
    );
  }
}
