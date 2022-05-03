import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/screens/viewOneDocument.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initilize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/launcher_icon"));
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      print(payload);
      print("yes");
      Map<String, dynamic> data = await json.decode(payload ?? '{ok: ok}');
      print(data);
      DocumentModule document;
      DocumentModule.getListDocuments([data['id'].toString()]).then((result) {
        if (result.length > 0) {
          document = result[0];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ViewOneDocument(
                      document, data['category'].toString() , data['module'].toString())));
        }
      });
    });
  }

  static void showNotificationOnForeground(RemoteMessage message) {
    final notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails("com.example.juridoc", "juridoc",
            importance: Importance.max, priority: Priority.high));
    _notificationsPlugin.show(
      DateTime.now().millisecond,
      message.notification!.title,
      message.notification!.body,
      notificationDetail,
      payload: json.encode(message.data),
    );
  }
}
