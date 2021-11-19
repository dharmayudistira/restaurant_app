import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_app/app/utils/background_service.dart';
import 'package:restaurant_app/app/utils/notification_helper.dart';
import 'package:restaurant_app/app/utils/styles.dart';

import 'app/routes/app_pages.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  final NotificationHelper _helper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if(GetPlatform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _helper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(
        textTheme: myTextTheme,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
