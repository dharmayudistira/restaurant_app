import 'package:get/get.dart';

import '../controllers/detail_restaurant_controller.dart';

class DetailRestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRestaurantController>(
      () => DetailRestaurantController(),
    );
  }
}
