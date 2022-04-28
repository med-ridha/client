import 'package:flutter/material.dart';
import 'package:juridoc/screens/welcome/login.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/orDivider.dart';
import 'package:juridoc/widgets/reset_form.dart';
import 'package:juridoc/widgets/secondary_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
                    height: /*60*/ height * 0.06,
                  ),
                  ResetForm(),
                  SizedBox(
                    height: /*20*/ height * 0.04,
                  ),
                  SizedBox(height: /*5*/ height * 0.01),
                  OrDivider(),
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
      ),
    );
  }
}
