import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        children: [
          Obx(
            () => ListTile(
              title: Text(
                "Reminder",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Get reminder every 11:00 AM",
                style: Theme.of(context).textTheme.caption,
              ),
              trailing: Switch.adaptive(
                value: controller.isReminderActive.value,
                onChanged: (newValue) {
                  controller.updateReminderState(newValue);
                },
                activeColor: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Settings",
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      leading: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.longArrowAltLeft,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      elevation: 0,
      backgroundColor: kPrimaryColor,
    );
  }
}
