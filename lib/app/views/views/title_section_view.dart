import 'package:flutter/material.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';

class TitleSectionView extends StatelessWidget {
  final String title;

  TitleSectionView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 16,
          color: kPrimaryColor,
        ),
        SizedBox(width: dimenSmall),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
