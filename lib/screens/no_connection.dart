import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/1_No Connection.png",
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
