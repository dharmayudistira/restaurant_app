import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/app/data/models/restaurant_response.dart';
import 'package:restaurant_app/app/data/models/restaurant_response_model.dart';
import 'package:restaurant_app/app/data/providers/restaurant_response_provider.dart';
import 'package:restaurant_app/app/modules/home/controllers/home_controller.dart';

import 'home_controller_test.mocks.dart';

@GenerateMocks([RestaurantResponseProvider])
void main() {
  test('fetch all restaurant should be success', () async {
    // arrange
    final service = MockRestaurantResponseProvider();
    final homeController = HomeController();
    final expectedResult = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
      ]
    };

    // act
    when(service.fetchAllRestaurant()).thenAnswer((_) async {
      return RestaurantResponse.fromJson(expectedResult);
    });
    final response = await service.fetchAllRestaurant();
    homeController.setListRestaurant(response.restaurants);

    // assert
    final actualResult = homeController.state;

    expect(actualResult,
        isA<List<Restaurant>>()); // match instance of List<Restaurant>
    expect(
        actualResult?.length, response.restaurants?.length); // match list size
  });

  test('fetch all restaurant should be failed', () async {
    // arrange
    var homeController = HomeController();

    // act
    homeController.onInit();

    // assert
    final actualResult = homeController.state;
    expect(actualResult, null); // match null
  });
}
