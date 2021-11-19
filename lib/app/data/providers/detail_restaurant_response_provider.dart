import 'package:get/get.dart';
import 'package:restaurant_app/app/utils/api_constants.dart';

import '../models/detail_restaurant_response_model.dart';

class DetailRestaurantResponseProvider extends GetConnect {
  Future<DetailRestaurantResponse?> fetchDetailRestaurant(String id) async {
    final response = await get(restaurantBaseUrl + "detail/$id");

    if (!response.hasError) {
      return DetailRestaurantResponse.fromJson(response.body);
    } else {
      return Future.error(
          "Something went wrong while fetching restaurant details");
    }
  }

  Future<bool> sendReview(String? id, String? name, String? review) async {
    final body = ({
      "id": id,
      "name": name,
      "review": review,
    });

    final response = await post(
      restaurantBaseUrl + "review",
      body,
    );

    if (response.hasError) {
      print(response.bodyString);
      return false;
    } else {
      return true;
    }
  }
}
