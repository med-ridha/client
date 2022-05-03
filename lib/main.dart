import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:juridoc/firebase/services/local_notification.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/module/FireBaseModule.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/screens/home.dart';
import 'package:juridoc/screens/viewOneCategory.dart';
import 'package:juridoc/screens/viewOneDocument.dart';
import 'package:juridoc/screens/welcome/login.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/screens/welcome/onboarding_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  var _message = FirebaseMessaging.instance;
  await _message.requestPermission(
    alert: true,
    badge: true,
    provisional: true,
    sound: true,
  );

  await UserPrefs.init();

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

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("yses");
        DocumentModule document;
        DocumentModule.getListDocuments([message.data['id']]).then((result) {
          if (result.length > 0) {
            document = result[0];
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ViewOneDocument(document,
                        message.data['category'], message.data['module'])));
          }
        });
      }
    });

    LocalNotificationService.initilize(context);
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.showNotificationOnForeground(message);
      print(message.notification!.body);
      print(message.notification!.title);
      print(message.data);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("yses");
      DocumentModule document;
      DocumentModule.getListDocuments([message.data['id']])
          .then((result) async {
        if (result.length > 0) {
          document = result[0];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ViewOneDocument(document,
                      message.data['category'], message.data['module'])));
        }
      });
    });
  }

  Future<Widget> loadFromFuture() async {
    if (!logedIn) {
      await FirebaseMessaging.instance.unsubscribeFromTopic("new");
      return Future.value(new OnboardingScreen());
    } else {
      //await notif.Notification().initState();
      await FirebaseMessaging.instance.subscribeToTopic("new");
      String notifId = await FirebaseModule.getFireBaseId() ?? '';
      await UserModule.check(notifId, UserPrefs.getEmail() ?? '');
      logedIn = UserPrefs.getIsLogedIn()!;
      if (!logedIn) {
        await FirebaseMessaging.instance.unsubscribeFromTopic("new");
        return Future.value(new OnboardingScreen());
      } else {
        return Future.value(new HomeScreen(0));
      }
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
