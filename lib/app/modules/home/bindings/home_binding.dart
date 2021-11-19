import 'package:get/get.dart';
import 'package:restaurant_app/app/controllers/database_controller.dart';
import 'package:restaurant_app/app/controllers/setting_preference_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(DatabaseController());
    Get.put(SettingPreferenceController());
  }
}
