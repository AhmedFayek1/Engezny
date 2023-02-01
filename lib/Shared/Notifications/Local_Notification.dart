import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
        static final _notifications = FlutterLocalNotificationsPlugin();
        static final onNotification = BehaviorSubject<String>();

        
        
Future<void> initialize() async {
  const AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings settings = InitializationSettings(android: android); 
  await _notifications.initialize(settings);
}       

static Future _notificationDetails() async
{
  return NotificationDetails(
    android: AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    ),
  );
}






static Future init({bool initScheduled = false}) async {
  final android = AndroidInitializationSettings('@mipmap/ic_launcher');
  final settings = InitializationSettings(android: android);
  await _notifications.initialize(
    settings,
    onDidReceiveNotificationResponse: (payload) async {
      //onNotification.add(payload);
    }
  );
}

static Future showLocalNotification({
  required int id,
  required String title,
  required String body,
  required String payload,
}) async =>
    _notifications.show(
    id,
    title,
    body,
    await _notificationDetails(),
    payload: payload,
  );

}