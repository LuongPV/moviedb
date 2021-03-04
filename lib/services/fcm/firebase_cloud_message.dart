import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_db/utils/logger/logger.dart';

void initCloudMessageService() {
  WidgetsFlutterBinding.ensureInitialized();
  final _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.getToken().then((token) {
    Logger.d('Firebase cloud message token: $token');
  });
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      Logger.d('Firebase onMessage: $message');
    },
    onBackgroundMessage: backgroundMessageHandler,
  );
}

Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
  Logger.d('Firebase onBackgroundMessage: $message');
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
  }
}
