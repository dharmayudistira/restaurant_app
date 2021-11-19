import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/data/models/restaurant_response.dart';
import 'package:restaurant_app/app/routes/app_pages.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';
import 'package:restaurant_app/app/views/views/empty_search_view.dart';
import 'package:restaurant_app/app/views/views/error_view.dart';
import 'package:restaurant_app/app/views/views/list_item_view.dart';
import 'package:restaurant_app/app/views/views/loading_view.dart';

import '../controllers/search_restaurant_controller.dart';

class SearchRestaurantView extends GetView<SearchRestaurantController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Search Restaurant",
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            margin: const EdgeInsets.only(
              left: dimenMedium,
              bottom: dimenMedium,
              right: dimenMedium,
            ),
            child: Card(
              elevation: dimenSmall,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: dimenMedium),
                child: _buildSearchBar(context),
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          controller.obx(
            (state) => _buildSearchResult(state),
            onLoading: Expanded(child: LoadingView()),
            onEmpty: Expanded(
              child: EmptySearchView(),
            ),
            onError: (errorMessage) => Expanded(
              child: ErrorView(
                message: errorMessage ?? "Something went wrong",
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _buildSearchBar(BuildContext context) {
    return TextFormField(
      controller: controller.searchController,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.text,
      onFieldSubmitted: (query) {
        controller.searchController.text = query;
        controller.searchRestaurant();
      },
      decoration: InputDecoration(
        labelStyle: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: kSecondaryColor),
        labelText: "Search your favorite restaurant",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        suffixIcon: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.search,
            color: kPrimaryColor,
          ),
          onPressed: () {
            controller.searchRestaurant();
          },
        ),
      ),
    );
  }

  Widget _buildSearchResult(List<Restaurant>? state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state?.length,
        itemBuilder: (ctx, idx) {
          return ListItemView(
            restaurant: state?[idx],
            callback: () {
              Get.toNamed(Routes.DETAIL_RESTAURANT, arguments: state?[idx].id);
            },
          );
        },
      ),
    );
  }
}
