import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_db/helpers/notification/notification_manager.dart' as notification_manager;
import 'package:movie_db/utils/logger/logger.dart';

void initCloudMessageService() {
  WidgetsFlutterBinding.ensureInitialized();
  final _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.getToken().then((token) {
    Logger.d('Firebase cloud message token: $token');
  });
  _firebaseMessaging.onTokenRefresh.listen((newToken) {
    Logger.d('Firebase cloud message new token refresh: $newToken');
  });
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      Logger.d('Firebase onMessage: $message');
      showNotification(message);
    },
    onBackgroundMessage: backgroundMessageHandler,
  );
  Logger.d('Done initializing firebase cloud message');
}

Future<dynamic> backgroundMessageHandler(Map<String, dynamic> message) async {
  Logger.d('Firebase onBackgroundMessage: $message');
  showNotification(message);
}

void showNotification(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    notification_manager.showNotification(data['title'], data['body']);
  }
}
