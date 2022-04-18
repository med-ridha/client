import 'package:flutter/material.dart';
import 'package:juridoc/screens/welcome/reset_password.dart';
import 'package:juridoc/screens/welcome/signup.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/login_form.dart';
import 'package:juridoc/widgets/orDivider.dart';
import 'package:juridoc/widgets/secondary_button.dart';

class LogInScreen extends StatelessWidget {
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
                  height: /*60*/ height * 0.06,
                ),
                LogInForm(),
                SizedBox(
                  height: /*20*/ height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen()));
                  },
                  child: Text(
                    'Mot de passe oublié?',
                    style: TextStyle(
                      color: kZambeziColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: /*5*/ height * 0.01),
                OrDivider(),
                SecondaryButton(
                    buttonText: "S'inscrire",
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.create))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
