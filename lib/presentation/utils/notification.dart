import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'logger/logger.dart';

const _channelIdDefault = 'channel id';
const _channelNameDefault = 'channel name';
const _channelDescriptionDefault = 'channel description';

Future<void> showNotification(
  String title,
  String body, {
  Function(String? playload)? onTapNotification,
  int notificationId = 0,
  String channelId = _channelIdDefault,
  String channelName = _channelNameDefault,
  String channelDescription = _channelDescriptionDefault,
  String? payload,
}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    channelId,
    channelName,
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_notification');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) =>
        selectNotification(payload, onTapNotification),
  );
  await flutterLocalNotificationsPlugin.show(
      notificationId, title, body, platformChannelSpecifics,
      payload: payload);
  Logger.d('Done show notification with title = $title, body = $body');
}

Future selectNotification(
    String? payload, Function(String? playload)? onTapNotification) async {
  Logger.d('Tap on notification payload = $payload');
  if (onTapNotification != null) {
    onTapNotification(payload);
  }
}
