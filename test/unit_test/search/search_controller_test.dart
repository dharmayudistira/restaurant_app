import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/app/data/models/restaurant_response.dart';
import 'package:restaurant_app/app/data/models/search_restaurant_response_model.dart';
import 'package:restaurant_app/app/data/providers/search_restaurant_response_provider.dart';
import 'package:restaurant_app/app/modules/search_restaurant/controllers/search_restaurant_controller.dart';

import 'search_controller_test.mocks.dart';

@GenerateMocks([SearchRestaurantResponseProvider])
void main() {
  test('search restaurant should be success', () async {
    // arrange
    final service = MockSearchRestaurantResponseProvider();
    final searchController = SearchRestaurantController();

    var restaurantName = "Makan Mudah";
    var expectedResult = {
      "error": false,
      "founded": 1,
      "restaurants": [
        {
          "id": "fnfn8mytkpmkfw1e867",
          "name": "Makan mudah",
          "description": "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
          "pictureId": "22",
          "city": "Medan",
          "rating": 3.7
        }
      ]
    };

    // act
    when(service.searchRestaurant(restaurantName)).thenAnswer((_) async {
      return SearchRestaurantResponse.fromJson(expectedResult);
    });
    final response = await service.searchRestaurant(restaurantName);
    searchController.setSearchRestaurants(response?.restaurants);

    // assert
    final actualResult = searchController.state;

    expect(actualResult, isA<List<Restaurant>>()); // match instance of List<Restaurant>
    expect(actualResult?.length, response?.restaurants?.length); // match list size
    expect(actualResult?[0], isA<Restaurant>()); // match instance of Restaurant
  });

  test('search restaurant should be failed', () async {
    // arrange
    final searchController = SearchRestaurantController();

    // act
    searchController.onInit();
    searchController.searchRestaurant();

    // assert
    final actualResult = searchController.state;

    expect(actualResult, null); // match null
  });
}