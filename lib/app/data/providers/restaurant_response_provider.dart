import 'package:get/get.dart';
import 'package:restaurant_app/app/utils/api_constants.dart';

import '../models/restaurant_response_model.dart';

class RestaurantResponseProvider extends GetConnect {
  Future<RestaurantResponse> fetchAllRestaurant() async {
    final response = await get(restaurantBaseUrl + "list");

    if (!response.hasError) {
      return RestaurantResponse.fromJson(response.body);
    } else {
      return Future.error("Something went wrong while fetching restaurants");
    }
  }
}
