import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:restaurant_app/app/data/providers/restaurant_response_provider.dart';
import 'package:restaurant_app/app/utils/notification_helper.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static final String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _helper = NotificationHelper();

    var randomIndex = Random().nextInt(20);
    var result = await RestaurantResponseProvider().fetchAllRestaurant();
    var data = result.restaurants?[randomIndex];

    await _helper.showNotification(
      flutterLocalNotificationsPlugin,
      data,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
