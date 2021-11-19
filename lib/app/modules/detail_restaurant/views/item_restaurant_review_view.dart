import 'package:flutter/material.dart';
import 'package:restaurant_app/app/data/models/detail_restaurant_response_model.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';

class ItemRestaurantReviewView extends StatelessWidget {
  final CustomerReviews? review;

  ItemRestaurantReviewView({
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: dimenSmall,
      margin: const EdgeInsets.only(
        right: dimenSmall,
        bottom: dimenMedium,
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(dimenMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/img_dummy_customer.jpg"),
                ),
                SizedBox(width: dimenSmall),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review?.name ?? "Unknown Name",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      review?.date ?? "No date",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: dimenMedium),
            Text(
              review?.review ?? "No review",
              style: Theme.of(context).textTheme.caption,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
