import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:async';

Future<void> _handleBachgroundMessage(RemoteMessage message) async {
  log("NOTIFICATION TITLE : ${message.notification!.title}");
  log("NOTIFICATION Body : ${message.notification!.body}");
}

class AppNotification {
  // static Future<String?> getFcmToken() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   final token = await messaging.getToken();

  //   return token;
  // }

  static Future<void> initNotification() async {
    await FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_handleBachgroundMessage);
  }
}
