import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';

class EmptySearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(dimenMedium),
        width: double.maxFinite,
        height: 150,
        child: Lottie.asset("assets/animations/empty_search_animation.json"),
      ),
    );
  }
}
