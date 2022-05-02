import 'dart:io';

import 'package:flutter/material.dart';
import 'package:juridoc/module/FireBaseModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/screens/home.dart';
import 'package:juridoc/screens/welcome/login.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/screens/welcome/onboarding_screen.dart';
import 'package:juridoc/firebase/services/notifications.dart' as notif;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseModule.init();
  await UserPrefs.init();
  await notif.Notification().initState();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Juridoc', home: Init());
  }
}

class Init extends StatefulWidget {
  const Init({Key? key}) : super(key: key);


  @override
  InitState createState() => InitState();
}

class InitState extends State<Init> {
  bool logedIn = false;

  @override
  void initState() {
    super.initState();
    logedIn = UserPrefs.getIsLogedIn()!;
  }

  Future<Widget> loadFromFuture() async {
    await Future.delayed(Duration(seconds: 2));
    if (!logedIn) {
      return Future.value(new OnboardingScreen());
    } else {
      return Future.value(new HomeScreen(0));
    }
  }


  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Poppins'),
          home: SplashScreen(
              navigateAfterFuture: loadFromFuture(),
              title: new Text(
                'Bienvenue',
                style: titleText,
              ),
              image: new Image.asset('images/Logo.png'),
              photoSize: 200.0,
              backgroundColor: Colors.white,
              styleTextUnderTheLoader: new TextStyle(),
              loaderColor: Color(0xFF00a3af)),
          initialRoute: '/',
          routes: {
            '/homescreen': (context) => HomeScreen(0),
            '/loginscreen': (context) => LogInScreen()
          }),
    );
  }
}
