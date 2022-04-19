import 'package:flutter/material.dart';
import 'package:juridoc/theme.dart';

class SecondaryButton extends StatelessWidget {
  String buttonText = "";
  void Function()? func;
  Icon? icon;

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: kSecondaryColor,
    minimumSize: Size(88, 36),
    textStyle: TextStyle(fontSize: 16, color: kPrimaryColor),
  );

  SecondaryButton({required this.buttonText, this.func, this.icon});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: ElevatedButton(
        style: flatButtonStyle,
        onPressed: func,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(width: width * 0.05),
              Text(
                buttonText,
                style: textButton.copyWith(fontSize: 18, color: kPrimaryColor),
              ),
              IconButton(
                  color: kPrimaryColor,
                  onPressed: func,
                  icon: icon!),
            ]),
      ),
    ));
  }
}
