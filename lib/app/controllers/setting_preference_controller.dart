import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_app/app/utils/preference_constants.dart';

class SettingPreferenceController extends GetxController {
  late GetStorage prefManager;

  @override
  void onInit() {
    super.onInit();
    prefManager = GetStorage();
  }

  void setReminderPreference(bool state) {
    prefManager.write(keyReminder, state);
  }

  bool getReminderPreference() {
    return prefManager.read(keyReminder) ?? false;
  }
}
