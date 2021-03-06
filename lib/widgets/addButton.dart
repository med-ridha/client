import 'package:flutter/material.dart';
import 'package:juridoc/theme.dart';

class AddButton extends StatelessWidget {
  void Function()? func;
  IconData? icon;
  Color? color;

  AddButton({this.func, this.icon, this.color});
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
            icon: Icon(icon, size: 40, color: color ?? null)),
      ),
    );
  }
}
