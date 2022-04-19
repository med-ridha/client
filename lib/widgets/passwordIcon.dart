import 'package:flutter/material.dart';
import 'package:juridoc/theme.dart';

class PasswordIcon extends StatefulWidget {
  void Function()? func;
  PasswordIcon(this.func);
  @override
  PasswordIconState createState() => PasswordIconState(this.func!);
}

class PasswordIconState extends State<PasswordIcon> {
  bool _isObscure = true;
  void Function() func;
  PasswordIconState(this.func);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isObscure = !_isObscure;
          func();
        });
      },
      icon: _isObscure
          ? Icon(
              Icons.visibility_off,
              color: Colors.black,
            )
          : Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
    );
  }
}
