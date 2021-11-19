import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/modules/home/controllers/home_controller.dart';
import 'package:restaurant_app/app/routes/app_pages.dart';
import 'package:restaurant_app/app/views/views/error_view.dart';
import 'package:restaurant_app/app/views/views/list_item_view.dart';
import 'package:restaurant_app/app/views/views/loading_view.dart';

class ListRestaurantView extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: state?.length,
        itemBuilder: (ctx, idx) {
          final restaurant = state?[idx];
          return ListItemView(
            restaurant: restaurant,
            callback: () {
              Get.toNamed(Routes.DETAIL_RESTAURANT, arguments: restaurant?.id);
            },
          );
        },
      ),
      onLoading: Container(
        child: LoadingView(),
      ),
      onError: (errorMessage) => Container(
        child: ErrorView(
          message: errorMessage ?? "Something went wrong",
        ),
      ),
    );
  }
}
