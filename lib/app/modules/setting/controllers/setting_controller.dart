import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/controllers/setting_preference_controller.dart';
import 'package:restaurant_app/app/utils/background_service.dart';
import 'package:restaurant_app/app/utils/date_time_helper.dart';

class SettingController extends GetxController {
  final _settingPreferenceController = Get.find<SettingPreferenceController>();

  var isReminderActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    isReminderActive.value = _settingPreferenceController.getReminderPreference();
  }

  void updateReminderState(bool state) async {
    _settingPreferenceController.setReminderPreference(state);
    isReminderActive.value = _settingPreferenceController.getReminderPreference();

    if (GetPlatform.isAndroid) {
      if (isReminderActive.value) {
        await AndroidAlarmManager.periodic(
          Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        );
      } else {
        await AndroidAlarmManager.cancel(1);
      }
    } else {
      Get.snackbar("We're sorry", "This feature only available on Android");
    }
  }
}
