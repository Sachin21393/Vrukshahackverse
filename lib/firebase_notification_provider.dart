import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'notification.dart';

class NotificationListenerProvider {
  final _firebaseMessaging = FirebaseMessaging.instance.getInitialMessage();

  void getMessage(BuildContext context) {
    print("dkfjkdfjkdfjdfdfd :::::::::::::::::::::::::::");
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      RemoteNotification notification = event.notification!;

      print(":::::::::::::::::::::::::::: $notification");

      // AppleNotification apple = event.notification!.apple!;
      AndroidNotification androidNotification = event.notification!.android!;

      if (notification != null && androidNotification != null) {
        ///Show local notification
        sendNotification(title: notification.title!, body: notification.body);
      }
    });
  }
}
