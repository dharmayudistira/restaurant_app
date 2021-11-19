import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/controllers/database_controller.dart';
import 'package:restaurant_app/app/data/models/detail_restaurant_response_model.dart';
import 'package:restaurant_app/app/data/models/favorite_restaurant_model.dart';
import 'package:restaurant_app/app/data/providers/detail_restaurant_response_provider.dart';

class DetailRestaurantController extends GetxController with StateMixin<DetailRestaurant?> {
  final databaseController = Get.find<DatabaseController>();

  late TextEditingController edtNameController;
  late TextEditingController edtReviewController;

  var isLoadingReview = false.obs;
  var isFavorite = false.obs;

  late String selectedRestaurantId;

  @override
  void onInit() {
    super.onInit();
    selectedRestaurantId = Get.arguments;

    checkFavorite(selectedRestaurantId);

    edtNameController = TextEditingController();
    edtReviewController = TextEditingController();

    refreshData();
  }

  @override
  void dispose() {
    edtNameController.dispose();
    edtReviewController.dispose();
    super.dispose();
  }

  void setDetailRestaurant(DetailRestaurant? restaurant) {
    change(restaurant, status: RxStatus.success());
  }

  void checkFavorite(String id) {
    databaseController.getFavoriteRestaurantById(id).then((value) {
      isFavorite.value = (value != null);
    });
  }

  void updateFavorite(DetailRestaurant? restaurant) {
    if (isFavorite.value) {
      deleteRestaurantFromFavorite(restaurant?.id ?? "null");
    } else {
      addRestaurantToFavorite(restaurant);
    }
  }

  void addRestaurantToFavorite(DetailRestaurant? restaurant) {
    final favoriteRestaurant = FavoriteRestaurant(
      id: restaurant?.id,
      pictureId: restaurant?.pictureId,
      name: restaurant?.name,
      rating: restaurant?.rating,
      city: restaurant?.city,
    );

    databaseController.insertRestaurant(favoriteRestaurant).whenComplete(() {
      isFavorite.value = true;
      Get.snackbar("Successfully added", "${restaurant?.name} added to your favorite");
    }).onError((_, __) {
      Get.snackbar("Failed to add restaurant", "${restaurant?.name} failed to add to your favorite");
    });
  }

  void deleteRestaurantFromFavorite(String id) {
    databaseController.deleteRestaurant(id).whenComplete(() {
      isFavorite.value = false;
      Get.snackbar("Successfully removed", "Removed from your favorite");
    }).onError((_, __) {
      Get.snackbar("Failed to remove restaurant", "Failed to remove from your favorite");
    });
  }

  void sendReview() {
    final isValid = _validateReviewInput();

    if (!isValid) {
      return;
    }

    isLoadingReview.value = true;
    DetailRestaurantResponseProvider().sendReview(
      value?.id,
      edtNameController.text,
      edtReviewController.text,
    ).then((value) {
      isLoadingReview.value = false;

      if (value) {
        refreshData();
        Get.back();
        Get.snackbar("Review Sucess", "Your review has been sent");
      } else {
        Get.snackbar("Review failed", "Something went wrong");
      }
    });
  }

  bool _validateReviewInput() {
    if (edtNameController.text.isEmpty) {
      Get.snackbar("Requirement Error", "Name field is required");
      return false;
    }

    if (edtReviewController.text.isEmpty) {
      Get.snackbar("Requirement Error", "Review field is required");
      return false;
    }

    return true;
  }

  void refreshData() {
    change(null, status: RxStatus.loading());
    DetailRestaurantResponseProvider()
        .fetchDetailRestaurant(selectedRestaurantId)
        .then((value) {
      if (value != null) {
        change(value.restaurant, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
      }
    }, onError: (errorMessage) {
      change(null, status: RxStatus.error(errorMessage));
      Get.snackbar("Something went wrong", "Please check your connection");
    });
  }
}
