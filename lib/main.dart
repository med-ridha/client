import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:juridoc/firebase/services/local_notification.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/module/FireBaseModule.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/module/service.dart';
import 'package:juridoc/screens/errors/something_went_wrong.dart';
import 'package:juridoc/screens/home.dart';
import 'package:juridoc/screens/errors/no_connection.dart';
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
  print("25" + message.data.toString());
  if (message.data['type'] == 'delete') {
    exit(0); 
  }
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
    FirebaseMessaging.onMessage.listen((message) async {
      LocalNotificationService.showNotificationOnForeground(message);
      print('94' + message.data.toString());
      if (message.data['type'] == 'delete') {
        await UserPrefs.clear();
        showError("Vous ne faits plus partie de JURIDOC");
        Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => LogInScreen()),
            ModalRoute.withName('/login'));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
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

  void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent);
  }

  Future<Widget> loadFromFuture() async {
    try {
      await http.get(Uri.parse(Service.url));

      if (!logedIn) {
        await FirebaseMessaging.instance.unsubscribeFromTopic("new");
        return Future.value(new OnboardingScreen());
      } else {
        String notifId = await FirebaseModule.getFireBaseId() ?? '';
        await UserModule.check(notifId, UserPrefs.getEmail() ?? '');
        logedIn = UserPrefs.getIsLogedIn()!;
        if (!logedIn) {
          await FirebaseMessaging.instance.unsubscribeFromTopic("new");
          return Future.value(new OnboardingScreen());
        } else {
          await FirebaseMessaging.instance.subscribeToTopic("new");
          return Future.value(new HomeScreen(0));
        }
      }
    } on SocketException catch (err) {
      if (err.osError!.errorCode == 101 || err.osError!.errorCode == 110) {
        showError("make sure you are connected to the internet");
        return Future.value(new NoConnectionScreen());
      }
      print(err);
    }
    return Future.value(new SomethingWentWrongScreen());
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
