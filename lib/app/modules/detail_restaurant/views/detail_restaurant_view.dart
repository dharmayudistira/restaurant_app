import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/data/models/detail_restaurant_response_model.dart';
import 'package:restaurant_app/app/modules/detail_restaurant/views/item_restaurant_review_view.dart';
import 'package:restaurant_app/app/modules/detail_restaurant/views/restaurant_information_view.dart';
import 'package:restaurant_app/app/utils/api_constants.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';
import 'package:restaurant_app/app/views/views/empty_view.dart';
import 'package:restaurant_app/app/views/views/error_view.dart';
import 'package:restaurant_app/app/views/views/loading_view.dart';
import 'package:restaurant_app/app/views/views/outline_input_text_view.dart';
import 'package:restaurant_app/app/views/views/title_section_view.dart';

import '../controllers/detail_restaurant_controller.dart';
import 'item_restaurant_menu_view.dart';

class DetailRestaurantView extends GetView<DetailRestaurantController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarr(context),
      floatingActionButton: _buildFloatingActionButton(context),
      body: SafeArea(
        child: controller.obx(
          (state) => ListView(
            children: [
              SizedBox(height: dimenMedium),
              Padding(
                padding: const EdgeInsets.all(dimenSmall),
                child: _buildRestaurantPhoto(state),
              ),
              _buildDetailRestaurantContent(state, context),
            ],
          ),
          onLoading: Container(
            child: LoadingView(),
          ),
          onError: (errorMessage) => Container(
            child: Padding(
              padding: const EdgeInsets.all(dimenMedium),
              child: ErrorView(
                message: errorMessage ?? "Something Went Wrong",
              ),
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      onPressed: () {
        _buildReviewBottomSheet(context);
      },
      backgroundColor: kPrimaryColor,
      icon: FaIcon(
        FontAwesomeIcons.edit,
        size: 24,
      ),
      label: Text(
        "Write review".toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: Colors.white),
      ),
      elevation: dimenSmall,
    );
  }

  Widget _buildDetailRestaurantContent(
    DetailRestaurant? state,
    BuildContext context,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          child: RestaurantInformationView(restaurant: state),
        ),
        SizedBox(height: dimenMedium),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          child: TitleSectionView(title: "Description"),
        ),
        SizedBox(height: dimenSmall),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          child: Text(
            state?.description ?? "No description",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        SizedBox(height: dimenMedium),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          child: TitleSectionView(title: "List Food"),
        ),
        SizedBox(height: dimenSmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          width: double.maxFinite,
          height: 150,
          child: (controller.state?.menus?.foods != null)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state?.menus?.foods?.length,
                  itemBuilder: (ctx, idx) {
                    final food = state?.menus?.foods?[idx];

                    return ItemRestaurantMenuView(
                      name: food?.name ?? "Unknown food",
                      isFood: true,
                    );
                  },
                )
              : EmptyView(message: "No Foods"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          child: TitleSectionView(title: "List Drink"),
        ),
        SizedBox(height: dimenSmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          width: double.maxFinite,
          height: 150,
          child: (controller.state?.menus?.drinks != null)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state?.menus?.drinks?.length,
                  itemBuilder: (ctx, idx) {
                    final drink = state?.menus?.drinks?[idx];

                    return ItemRestaurantMenuView(
                      name: drink?.name ?? "Unknown drink",
                      isFood: false,
                    );
                  },
                )
              : EmptyView(message: "No drinks"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          child: TitleSectionView(title: "Customers Review"),
        ),
        SizedBox(height: dimenSmall),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
          margin: const EdgeInsets.only(bottom: dimenLarge * 2),
          height: 150,
          child: (controller.state?.customerReviews != null)
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state?.customerReviews?.length,
                  itemBuilder: (ctx, idx) {
                    final review = state?.customerReviews?[idx];

                    return Container(
                      child: ItemRestaurantReviewView(review: review),
                      width: 300,
                    );
                  },
                )
              : EmptyView(message: "No reviews"),
        ),
      ],
    );
  }

  AppBar _buildAppBarr(BuildContext context) {
    return AppBar(
      title: Text(
        "Restaurant Details",
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
      leading: IconButton(
        icon: FaIcon(
          FontAwesomeIcons.longArrowAltLeft,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      elevation: 0,
      backgroundColor: kPrimaryColor,
    );
  }

  Widget _buildRestaurantPhoto(DetailRestaurant? restaurant) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(dimenMedium),
      child: Stack(
        children: [
          Hero(
            tag: restaurant?.id ?? "null",
            child: Image.network(
              restaurantBaseImageUrl + "${restaurant?.pictureId}",
              fit: BoxFit.fill,
              width: double.maxFinite,
              errorBuilder: (_, __, ___) {
                return Center(
                  child: FaIcon(FontAwesomeIcons.exclamationTriangle),
                );
              },
            ),
          ),
          Positioned(
            bottom: dimenMedium,
            right: dimenMedium,
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.white,
              child: Obx(
                () => (controller.isFavorite.value)
                    ? FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: kPrimaryColor,
                      )
                    : FaIcon(
                        FontAwesomeIcons.heart,
                        color: kPrimaryColor,
                      ),
              ),
              onPressed: () {
                controller.updateFavorite(restaurant);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _buildReviewBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(dimenMedium),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              width: 50,
              height: dimenSmall,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(dimenSmall),
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: dimenMedium),
            OutlineInputTextView(
              labelText: "Your name",
              controller: controller.edtNameController,
              needCounter: false,
            ),
            SizedBox(height: dimenMedium),
            OutlineInputTextView(
              labelText: "Write a review",
              controller: controller.edtReviewController,
              needCounter: true,
            ),
            SizedBox(height: dimenMedium),
            Container(
              width: double.maxFinite,
              height: dimenLarge * 1.5,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: kPrimaryColor),
                ),
                child: Obx(
                  () => (controller.isLoadingReview.value)
                      ? LoadingView()
                      : Text(
                          "Send".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: kPrimaryColor),
                        ),
                ),
                onPressed: () {
                  controller.sendReview();
                },
              ),
            ),
            SizedBox(height: dimenMedium),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dimenSmall),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }
}
