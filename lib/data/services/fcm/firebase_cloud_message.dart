import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import '../../../presentation/utils/logger/logger.dart';

void initCloudMessageService() async {
  WidgetsFlutterBinding.ensureInitialized();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  Logger.d('Firebase cloud message token: $fcmToken');

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    Logger.d('Firebase cloud message new token refresh: $newToken');
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Logger.d('Got a message whilst in the foreground! data: ${message.data}');
    if (message.notification != null) {
      Logger.d(
          'Message also contained a notification: ${message.notification}');
    }
  });
  Logger.d('Done initializing firebase cloud message');
}

Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
  Logger.d('Firebase onBackgroundMessage: $message');
}
