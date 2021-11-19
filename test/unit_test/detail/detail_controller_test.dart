import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/app/controllers/database_controller.dart';
import 'package:restaurant_app/app/data/models/detail_restaurant_response_model.dart';
import 'package:restaurant_app/app/data/providers/detail_restaurant_response_provider.dart';
import 'package:restaurant_app/app/modules/detail_restaurant/controllers/detail_restaurant_controller.dart';

import 'detail_controller_test.mocks.dart';

@GenerateMocks([DetailRestaurantResponseProvider])
void main() {
  
  test('fetch detail restaurant should be success', () async {

    // arrange
    Get.put(DatabaseController()); // for injection

    final service = MockDetailRestaurantResponseProvider();
    final detailController = DetailRestaurantController();
    detailController.selectedRestaurantId = "rqdv5juczeskfw1e867";

    final restaurantId = "rqdv5juczeskfw1e867";
    final expectedResult = {
      "error": false,
      "message": "success",
      "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
          {
            "name": "Italia"
          },
          {
            "name": "Modern"
          }
        ],
        "menus": {
          "foods": [
            {
              "name": "Paket rosemary"
            },
            {
              "name": "Toastie salmon"
            }
          ],
          "drinks": [
            {
              "name": "Es krim"
            },
            {
              "name": "Sirup"
            }
          ]
        },
        "rating": 4.2,
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          }
        ]
      }
    };

    // act
    when(service.fetchDetailRestaurant(restaurantId)).thenAnswer((_) async {
      return DetailRestaurantResponse.fromJson(expectedResult);
    });
    final response = await service.fetchDetailRestaurant(restaurantId);
    detailController.setDetailRestaurant(response?.restaurant);

    // assert
    final actualResult = detailController.state;

    expect(actualResult, isA<DetailRestaurant>()); // match instance of DetailRestaurant
    expect(actualResult?.id, response?.restaurant?.id); // match value of id
    expect(actualResult?.name, response?.restaurant?.name); // match value of name
    expect(actualResult?.description, response?.restaurant?.description); // match value of description
    expect(actualResult?.city, response?.restaurant?.city); // match value of city
    expect(actualResult?.address, response?.restaurant?.address); // match value of address
    expect(actualResult?.pictureId, response?.restaurant?.pictureId); // match value of picture id
    expect(actualResult?.categories, isA<List<Categories>>()); // match instance of List<Categories>
    expect(actualResult?.categories?.length, response?.restaurant?.categories?.length); // match list size
    expect(actualResult?.rating, response?.restaurant?.rating); // match value of rating
    expect(actualResult?.customerReviews, isA<List<CustomerReviews>>()); // match instance of CustomerReviews
    expect(actualResult?.customerReviews?.length, response?.restaurant?.customerReviews?.length); // match list size
  });

}