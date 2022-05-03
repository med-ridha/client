import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:juridoc/firebase/model/pushnotification_model.dart';
import 'package:juridoc/firebase/services/local_notification.dart';

class Notification {
  late final FirebaseMessaging messaging;
  //model
  PushNotification? _notificationInfo;
  // register notification
  registerNotification() async {
    await Firebase.initializeApp();
    // instance for firebase messaging
    var _messaging = FirebaseMessaging.instance;
    // three type of state in notification
    // not determined (null), granted (true) and decline (false)
    // await _messaging.subscribeToTopic("new");
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted the permission");
      // main message
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        LocalNotificationService.showNotificationOnForeground(message);
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
          url: message.data['url'],
        );
      });
    } else {
      print("permission declined by user");
    }
  }

  Future<void> initState() async {
    //LocalNotificationService.initilize();
    registerNotification();
  }
}
