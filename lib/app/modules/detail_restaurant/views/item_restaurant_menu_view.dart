import 'package:flutter/material.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';

class ItemRestaurantMenuView extends StatelessWidget {
  final String name;
  final bool isFood;

  ItemRestaurantMenuView({
    required this.name,
    required this.isFood,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        right: dimenSmall,
        bottom: dimenMedium,
      ),
      clipBehavior: Clip.antiAlias,
      elevation: dimenSmall,
      child: Column(
        children: [
          Image.asset(
            (isFood)
                ? "assets/images/img_dummy_food.jpg"
                : "assets/images/img_dummy_drink.jpg",
            fit: BoxFit.cover,
            height: 100,
            width: 150,
          ),
          SizedBox(height: dimenSmall),
          Text(
            name,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
