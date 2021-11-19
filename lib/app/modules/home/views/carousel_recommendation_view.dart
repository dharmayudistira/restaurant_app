import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/app/data/models/restaurant_response.dart';
import 'package:restaurant_app/app/modules/home/controllers/home_controller.dart';
import 'package:restaurant_app/app/utils/api_constants.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';

class CarouselRecommendationView extends StatelessWidget {
  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> listRecommendationWidget = _controller
        .getRecommendationRestaurants()
        .map((restaurant) => _buildCarouselItem(restaurant, context))
        .toList();

    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: listRecommendationWidget,
    );
  }

  Card _buildCarouselItem(Restaurant? restaurant, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: dimenMedium),
      clipBehavior: Clip.antiAlias,
      elevation: dimenSmall,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              restaurantBaseImageUrl + "${restaurant?.pictureId}",
              fit: BoxFit.cover,
              width: double.maxFinite,
              errorBuilder: (_, __, ___) {
                return Center(
                  child: FaIcon(FontAwesomeIcons.exclamationTriangle),
                );
              },
            ),
          ),
          SizedBox(height: dimenSmall),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: dimenSmall),
            child: Text(
              restaurant?.name ?? "Unknown Restaurant",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: dimenSmall),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: dimenSmall),
            child: Text(
              restaurant?.description ?? "Unknown description",
              style: Theme.of(context).textTheme.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(dimenSmall),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.mapMarkerAlt,
                  size: 12,
                ),
                SizedBox(width: dimenSmall),
                Text(
                  restaurant?.city ?? "Unknown city",
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(width: dimenMedium),
                FaIcon(
                  FontAwesomeIcons.solidStar,
                  size: 12,
                ),
                SizedBox(width: dimenSmall),
                Text(
                  restaurant?.rating ?? "No rating",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
