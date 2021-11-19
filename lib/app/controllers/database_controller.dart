import 'package:get/get.dart';
import 'package:restaurant_app/app/data/database/database_helper.dart';
import 'package:restaurant_app/app/data/models/favorite_restaurant_model.dart';

class DatabaseController extends GetxController {
  var favoriteRestaurants = List<FavoriteRestaurant>.empty().obs;
  late DatabaseHelper _databaseHelper;

  @override
  void onInit() {
    super.onInit();

    _databaseHelper = DatabaseHelper();
  }

  void _getAllRestaurants() async {
    favoriteRestaurants.value = await _databaseHelper.getFavoriteRestaurants();
  }

  Future<FavoriteRestaurant?> getFavoriteRestaurantById(String id) async {
    return await _databaseHelper.getFavoriteRestaurantById(id);
  }

  Future<void> insertRestaurant(FavoriteRestaurant restaurant) async {
    await _databaseHelper.insertRestaurant(restaurant);
    _getAllRestaurants();
  }

  Future<void> deleteRestaurant(String id) async {
    await _databaseHelper.deleteRestaurant(id);
    _getAllRestaurants();
  }
}
