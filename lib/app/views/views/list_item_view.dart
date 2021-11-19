import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurant_app/app/data/models/restaurant_response.dart';
import 'package:restaurant_app/app/utils/api_constants.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';

class ListItemView extends StatelessWidget {
  final Restaurant? restaurant;
  final Function callback;

  ListItemView({
    required this.restaurant,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: ListTile(
        isThreeLine: true,
        leading: Hero(
          tag: restaurant?.id ?? "null",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(dimenSmall),
            child: Image.network(
              restaurantBaseImageUrl + "${restaurant?.pictureId}",
              fit: BoxFit.cover,
              width: 100,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 100,
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.exclamationTriangle),
                  ),
                );
              },
            ),
          ),
        ),
        title: Text(
          restaurant?.name ?? "Unknown Restaurant",
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
                  restaurant?.city ?? "Unknown City",
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
                  restaurant?.rating ?? "No Rating",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            )
          ],
        ),
        trailing: FaIcon(
          FontAwesomeIcons.angleRight,
          color: kSecondaryColor,
        ),
      ),
    );
  }
}
