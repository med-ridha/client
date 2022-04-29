import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/secondBarUI.dart';

class Alert extends StatefulWidget {
  @override
  AlertState createState() => AlertState();
}

class AlertState extends State<Alert> with TickerProviderStateMixin {

  var _fireBase;

  @override
  void initState() {
    super.initState();
    _fireBase = FirebaseMessaging.instance;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double safePadding = MediaQuery.of(context).padding.top;
    return Stack(fit: StackFit.expand, children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(4, 9, 35, 1),
              Color.fromRGBO(39, 105, 171, 1),
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: safePadding,
                width: width,
                decoration: BoxDecoration(color: Colors.white70, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  children: [
                    AppBarUI(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: SecondBarUi("Alerte juridique", false),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 400,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text2(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text3(context),
                                  checkbox(context),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text4(context),
                                  button1(context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  Widget Text2() {
    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 300),
      child: Text(
        "Il est possible de choisir la fréquence à laquelle vous souhaiteriez recevoir cette alerte juridique.",
        textAlign: TextAlign.center,
        style: subTitle2,
      ),
    );
  }

  Widget Text3(BuildContext context) {
    return Text(
      "Alerte juridique:",
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),
    );
  }

  Widget checkbox(BuildContext context) {
    return CheckboxGroup(labels: <String>[
      "Je m'abonne à l'alerte Juridique",
    ], onSelected: (List<String> checked) => /*sub = !sub*/ print(checked.toString()));
  }

  Widget Text4(BuildContext context) {
    return Text(
      "Fréquence de l'alerte:",
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: kSecondaryColor),
    );
  }

  Widget button1(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {},
        child: Container(
            alignment: Alignment.center,
            height: 60,
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: kPrimaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Valider",
                        style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
