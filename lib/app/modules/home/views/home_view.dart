import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/modules/home/views/carousel_recommendation_view.dart';
import 'package:restaurant_app/app/modules/home/views/greeting_view.dart';
import 'package:restaurant_app/app/routes/app_pages.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';
import 'package:restaurant_app/app/views/views/error_view.dart';
import 'package:restaurant_app/app/views/views/loading_view.dart';
import 'package:restaurant_app/app/views/views/title_section_view.dart';

import '../controllers/home_controller.dart';
import 'list_restaurant_view.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: dimenMedium,
            left: dimenMedium,
            right: dimenMedium,
          ),
          child: OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return _buildHomeContentPortrait();
              } else {
                return _buildHomeContentLandscape();
              }
            },
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  FabCircularMenu _buildFloatingActionButton() {
    return FabCircularMenu(
      children: [
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.solidHeart,
            color: Colors.white,
          ),
          onPressed: () {
            Get.toNamed(Routes.FAVORITE);
          },
        ),
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Get.toNamed(Routes.SEARCH_RESTAURANT);
          },
        ),
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.cog,
            color: Colors.white,
          ),
          onPressed: () {
            Get.toNamed(Routes.SETTING);
          },
        ),
      ],
      fabColor: kPrimaryColor,
      ringColor: kPrimaryColor.withOpacity(0.8),
      fabOpenIcon: FaIcon(FontAwesomeIcons.bars, color: Colors.white),
      fabCloseIcon: FaIcon(FontAwesomeIcons.times, color: Colors.white),
      ringDiameter: Get.size.width,
    );
  }

  Widget _buildHomeContentPortrait() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GreetingView(),
        SizedBox(height: dimenMedium),
        TitleSectionView(title: "Recommendation"),
        SizedBox(height: dimenSmall),
        controller.obx(
          (state) => CarouselRecommendationView(),
          onLoading: Container(
            height: 200,
            child: LoadingView(),
          ),
          onError: (errorMessage) => Container(
            height: 200,
            child: ErrorView(
              message: errorMessage ?? "Something went wrong",
            ),
          ),
        ),
        SizedBox(height: dimenSmall),
        TitleSectionView(title: "List All Restaurant"),
        SizedBox(height: dimenSmall),
        Expanded(
          child: ListRestaurantView(),
        ),
      ],
    );
  }

  Widget _buildHomeContentLandscape() {
    return ListView(
      children: [
        GreetingView(),
        SizedBox(height: dimenMedium),
        TitleSectionView(title: "Recommendation"),
        SizedBox(height: dimenSmall),
        controller.obx(
          (state) => CarouselRecommendationView(),
          onLoading: Container(
            height: 200,
            child: LoadingView(),
          ),
          onError: (errorMessage) => Container(
            height: 200,
            child: ErrorView(
              message: errorMessage ?? "Something went wrong",
            ),
          ),
        ),
        SizedBox(height: dimenSmall),
        TitleSectionView(title: "List All Restaurant"),
        SizedBox(height: dimenSmall),
        ListRestaurantView(),
      ],
    );
  }
}
