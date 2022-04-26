import 'package:flutter/material.dart';
import 'package:juridoc/theme.dart';

class SendButton extends StatelessWidget {
  void Function()? func;
  IconData? icon;

  SendButton({this.func, this.icon});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double heigth = MediaQuery.of(context).size.height;
    return Container(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80), color: kPrimaryColor),
        child: IconButton(
            padding: EdgeInsets.zero,
            color: Colors.white,
            onPressed: func,
            icon: Icon(icon ?? Icons.send, color: Colors.white, size: 30)),
      ),
    );
  }
}
