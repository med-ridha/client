import 'package:flutter/material.dart';
import 'package:juridoc/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  void Function()? func;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: kPrimaryColor,
    minimumSize: Size(88, 36),
    textStyle: TextStyle(
        fontSize: 19 
    ),
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );
  PrimaryButton({required this.buttonText, this.func});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width * 0.6,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: TextButton(
                style: flatButtonStyle,
                onPressed: func ?? () {},
                child: Text(buttonText, style: TextStyle(color: Colors.white))))
        );
  }
}
