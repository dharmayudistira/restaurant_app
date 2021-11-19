import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/data/models/favorite_restaurant_model.dart';
import 'package:restaurant_app/app/routes/app_pages.dart';
import 'package:restaurant_app/app/utils/api_constants.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';
import 'package:restaurant_app/app/views/views/empty_view.dart';

import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarr(context),
      body: Obx(() {
        return (controller.databaseController.favoriteRestaurants.isEmpty)
            ? EmptyView(
                message:
                    "Your favorite restaurants is empty\nFind out more and add your favorite restaurant",
              )
            : GridView.count(
                crossAxisCount: 2,
                children: controller.databaseController.favoriteRestaurants
                    .map((element) => GridItemView(favorite: element))
                    .toList(),
              );
      }),
    );
  }

  AppBar _buildAppBarr(BuildContext context) {
    return AppBar(
      title: Text(
        "Your Favorite Restaurants",
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
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
}

class GridItemView extends StatelessWidget {
  final FavoriteRestaurant favorite;

  const GridItemView({
    required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_RESTAURANT, arguments: favorite.id);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: dimenSmall,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Hero(
                tag: favorite.id ?? "null",
                child: Image.network(
                  restaurantBaseImageUrl + "${favorite.pictureId}",
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      child: Center(
                        child: FaIcon(FontAwesomeIcons.exclamationTriangle),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                isThreeLine: true,
                title: Text(
                  favorite.name ?? "Unknown Restaurant",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.mapMarkerAlt,
                          size: 12,
                        ),
                        SizedBox(width: dimenSmall),
                        Text(
                          favorite.city ?? "Unknown City",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidStar,
                          size: 12,
                        ),
                        SizedBox(width: dimenSmall),
                        Text(
                          favorite.rating ?? "No Rating",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
