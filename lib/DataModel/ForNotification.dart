import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificaionApi {
    static final _Notification = FlutterLocalNotificationsPlugin();
  static Future init({bool Schedulaed = false}) async {
    var androidSetting = AndroidInitializationSettings('minmap/ic_launcher');
    var iossetting = IOSInitializationSettings();
    final Settings = InitializationSettings(android: androidSetting , iOS: iossetting);
    await _Notification.initialize(Settings);
  }
  static Future _NotificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channle id', 'channel name',
          channelDescription: 'Channle desc', importance: Importance.max),
    );
  }
  static Future ShowNotification({
    int Id = 0,
    String? Title,
    String? Body,
    String? Payload,
  }) async =>
      _Notification.show(Id, Title, Body, await _NotificationDetails(),
          payload: Payload);
}
