import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:juridoc/firebase/model/pushnotification_model.dart';
import 'package:juridoc/firebase/services/local_notification.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message");
}

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

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification!.title,
        body: initialMessage.notification!.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
        url: initialMessage.data['url'],
      );
    }
  }

  background() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
        url: message.data['url'],
      );
    });
  }

  Future<void> initState() async {
    LocalNotificationService.initilize();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    registerNotification();
    background();
    checkForInitialMessage();
  }

}
