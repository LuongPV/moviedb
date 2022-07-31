import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../utils/logger/logger.dart';

const _CHANNEL_ID_DEFAULT = 'channel id';
const _CHANNEL_NAME_DEFAULT = 'channel name';
const _CHANNEL_DESCRIPTION_DEFAULT = 'channel description';

Future<void> showNotification(
  String title,
  String body, {
  Function(String playload) onTapNotification,
  int notificationId = 0,
  String channelId = _CHANNEL_ID_DEFAULT,
  String channelName = _CHANNEL_NAME_DEFAULT,
  String channelDescription = _CHANNEL_DESCRIPTION_DEFAULT,
  String payload,
}) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channelId,
    channelName,
    channelDescription,
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_notification');
  final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
  await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) => selectNotification(payload, onTapNotification),
  );
  await flutterLocalNotificationsPlugin.show(notificationId, title, body, platformChannelSpecifics, payload: payload);
  Logger.d('Done show notification with title = $title, body = $body');
}

Future selectNotification(String payload, Function(String playload) onTapNotification) async {
  Logger.d('Tap on notification payload = $payload');
  if (onTapNotification != null) {
    onTapNotification(payload);
  }
}