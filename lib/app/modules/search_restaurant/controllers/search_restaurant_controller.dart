import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/data/models/restaurant_response.dart';
import 'package:restaurant_app/app/data/providers/search_restaurant_response_provider.dart';

class SearchRestaurantController extends GetxController with StateMixin<List<Restaurant>?> {
  late TextEditingController searchController;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    change(null, status: RxStatus.empty());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void setSearchRestaurants(List<Restaurant>? restaurants) {
    change(restaurants, status: RxStatus.success());
  }

  void searchRestaurant() {
    final query = searchController.text;

    change(null, status: RxStatus.loading());
    SearchRestaurantResponseProvider().searchRestaurant(query).then((value) {
      if (value?.restaurants?.isNotEmpty == true) {
        change(value?.restaurants, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
        Get.snackbar(
            "No restaurant found", "Please try again with another keyword");
      }
    }, onError: (errorMessage) {
      change(null, status: RxStatus.error(errorMessage));
      Get.snackbar("Something went wrong", "Please check your connection");
    });
  }
}
