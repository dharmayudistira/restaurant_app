import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/data/models/restaurant_response.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin plugin,
  ) async {
    var initSettingsForAndroid = AndroidInitializationSettings('app_icon');
    var initSettingsForIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initSettings = InitializationSettings(
      android: initSettingsForAndroid,
      iOS: initSettingsForIOS,
    );

    await plugin.initialize(
      initSettings,
      onSelectNotification: (payload) async {
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin plugin,
    Restaurant? restaurant,
  ) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurant channel";

    var androidPlatformSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iOSPlatformSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformSpecifics,
      iOS: iOSPlatformSpecifics,
    );

    var titleNotification = "Restaurant App";
    var restaurantName = restaurant?.name ?? "Unknown Name";

    await plugin.show(
      0,
      titleNotification,
      restaurantName,
      platformChannelSpecifics,
      payload: json.encode(restaurant?.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((payload) async {
      var data = Restaurant.fromJson(json.decode(payload));
      Get.toNamed(route, arguments: data.id);
    });
  }
}
