import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/app/data/models/detail_restaurant_response_model.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';

class RestaurantInformationView extends StatelessWidget {
  final DetailRestaurant? restaurant;

  RestaurantInformationView({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          restaurant?.name ?? "Unknown Restaurant",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.mapMarkerAlt,
              size: 12,
            ),
            SizedBox(width: dimenSmall),
            Text(
              restaurant?.city ?? "Unknown City",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: dimenMedium),
            FaIcon(
              FontAwesomeIcons.solidStar,
              size: 12,
            ),
            SizedBox(width: dimenSmall),
            Text(
              restaurant?.rating ?? "No Rating",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ],
    );
  }
}
