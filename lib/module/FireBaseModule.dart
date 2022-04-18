import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseModule {
  static Future<void> init() async {
    await Firebase.initializeApp();
  }

  static Future<String?> getFireBaseId() async {
    return FirebaseMessaging.instance.getToken();
  }
}
