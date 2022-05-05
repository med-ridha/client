import 'package:flutter/material.dart';

class SomethingWentWrongScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/3_Something Went Wrong.png",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
