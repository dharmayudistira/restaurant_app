import 'dart:math';

import 'package:get/get.dart';
import 'package:restaurant_app/app/data/models/restaurant_response.dart';
import 'package:restaurant_app/app/data/providers/restaurant_response_provider.dart';
import 'package:restaurant_app/app/routes/app_pages.dart';
import 'package:restaurant_app/app/utils/notification_helper.dart';

class HomeController extends GetxController with StateMixin<List<Restaurant>?> {
  final NotificationHelper _helper = NotificationHelper();

  @override
  void onInit() {
    super.onInit();
    _helper.configureSelectNotificationSubject(Routes.DETAIL_RESTAURANT);

    change(null, status: RxStatus.loading());
    RestaurantResponseProvider().fetchAllRestaurant().then((value) {
      if (value.restaurants?.isNotEmpty == true) {
        change(value.restaurants, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    }, onError: (errorMessage) {
      change(null, status: RxStatus.error(errorMessage));
      Get.snackbar("Something went wrong", "Please check your connection");
    });
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  List<Restaurant?> getRecommendationRestaurants() {
    final listRandomIndex = List.generate(3, (index) => Random().nextInt(20));

    final firstRestaurant = value?[listRandomIndex[0]];
    final secondRestaurant = value?[listRandomIndex[1]];
    final thirdRestaurant = value?[listRandomIndex[2]];

    return <Restaurant?>[firstRestaurant, secondRestaurant, thirdRestaurant];
  }

  void setListRestaurant(List<Restaurant>? restaurants) {
    change(restaurants, status: RxStatus.success());
  }
}
