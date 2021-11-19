import 'package:get/get.dart';
import 'package:restaurant_app/app/utils/api_constants.dart';

import '../models/search_restaurant_response_model.dart';

class SearchRestaurantResponseProvider extends GetConnect {
  Future<SearchRestaurantResponse?> searchRestaurant(String query) async {
    final response = await get(
      restaurantBaseUrl + "search",
      query: ({"q": query}),
    );

    if (!response.hasError) {
      return SearchRestaurantResponse.fromJson(response.body);
    } else {
      return Future.error("Something went wrong while fetching restaurants");
    }
  }
}
