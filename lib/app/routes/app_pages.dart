import 'package:get/get.dart';
import 'package:restaurant_app/app/modules/detail_restaurant/bindings/detail_restaurant_binding.dart';
import 'package:restaurant_app/app/modules/detail_restaurant/views/detail_restaurant_view.dart';
import 'package:restaurant_app/app/modules/favorite/bindings/favorite_binding.dart';
import 'package:restaurant_app/app/modules/favorite/views/favorite_view.dart';
import 'package:restaurant_app/app/modules/home/bindings/home_binding.dart';
import 'package:restaurant_app/app/modules/home/views/home_view.dart';
import 'package:restaurant_app/app/modules/search_restaurant/bindings/search_restaurant_binding.dart';
import 'package:restaurant_app/app/modules/search_restaurant/views/search_restaurant_view.dart';
import 'package:restaurant_app/app/modules/setting/bindings/setting_binding.dart';
import 'package:restaurant_app/app/modules/setting/views/setting_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RESTAURANT,
      page: () => DetailRestaurantView(),
      binding: DetailRestaurantBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_RESTAURANT,
      page: () => SearchRestaurantView(),
      binding: SearchRestaurantBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
