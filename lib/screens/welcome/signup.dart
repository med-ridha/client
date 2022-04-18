import 'package:flutter/material.dart';
import 'package:juridoc/screens/welcome/login.dart';
import 'package:juridoc/screens/welcome/reset_password.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/orDivider.dart';
import 'package:juridoc/widgets/secondary_button.dart';
import 'package:juridoc/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: /* 50 */ height * 0.07,
                ),
                Image.asset('images/Logo.png'),
                SizedBox(
                  height: /*60*/ height * 0.02,
                ),
                SignUpForm(),
                SizedBox(
                  height: /*20*/ height * 0.05,
                ),
                OrDivider(),
                //SizedBox(height: height * 0.01),
                SecondaryButton(
                    buttonText: "Connexion",
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogInScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.login)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
