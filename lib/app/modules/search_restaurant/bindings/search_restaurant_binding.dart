import 'package:get/get.dart';

import '../controllers/search_restaurant_controller.dart';

class SearchRestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchRestaurantController>(
      () => SearchRestaurantController(),
    );
  }
}
