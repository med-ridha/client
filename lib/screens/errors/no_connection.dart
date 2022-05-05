import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:juridoc/main.dart';
import 'package:juridoc/module/FireBaseModule.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/module/service.dart';
import 'package:juridoc/screens/errors/something_went_wrong.dart';
import 'package:juridoc/screens/home.dart';
import 'package:juridoc/screens/welcome/onboarding_screen.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/primary_button.dart';
import 'package:juridoc/widgets/secondary_button.dart';
import 'package:overlay_support/overlay_support.dart';

class NoConnectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NoConnectionScreenState();
}

class NoConnectionScreenState extends State<NoConnectionScreen> {
  bool done = false;
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
          Positioned(bottom: 100, left: 30, child: button1(context))
        ],
      ),
    );
  }

  Widget button1(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () async {
          setState(() {
            done = true;
          });
          var route = await loadFromFuture();
          if (route != null) {
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          }
          setState(() {
            done = false;
          });
        },
        child: Container(
            alignment: Alignment.center,
            height: 60,
            width: width * 0.4,
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
                      (!done)
                          ? Text(
                              "RETRY",
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          : SpinKitDualRing(size: 35, color: Colors.green),
                    ],
                  ),
                ],
              ),
            )));
  }

  Future<Route<Object?>?> loadFromFuture() async {
    bool logedIn = UserPrefs.getIsLogedIn() ?? false;
    try {
      await http.get(Uri.parse(Service.url));
      if (!logedIn) {
        await FirebaseMessaging.instance.unsubscribeFromTopic("new");
        return Future.value(MaterialPageRoute<Object?>(
            builder: (BuildContext context) => OnboardingScreen()));
      } else {
        String notifId = await FirebaseModule.getFireBaseId() ?? '';
        await UserModule.check(notifId, UserPrefs.getEmail() ?? '');
        logedIn = UserPrefs.getIsLogedIn()!;
        if (!logedIn) {
          await FirebaseMessaging.instance.unsubscribeFromTopic("new");
          return Future.value(new MaterialPageRoute<Object?>(
              builder: (BuildContext context) => OnboardingScreen()));
        } else {
          await FirebaseMessaging.instance.subscribeToTopic("new");
          return Future.value(new MaterialPageRoute<Object?>(
              builder: (BuildContext context) => HomeScreen(0)));
        }
      }
    } on SocketException catch (err) {
      if (err.osError!.errorCode == 101|| err.osError!.errorCode == 110) {
        showError("make sure you are connected to the internet");
        setState(() {
          done = false;
        });
        return null;
      }
    }
    return Future.value(new MaterialPageRoute<Object?>(
        builder: (BuildContext context) => SomethingWentWrongScreen()));
  }

  void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent);
  }
}
