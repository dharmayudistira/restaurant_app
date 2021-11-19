import 'package:flutter/material.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: kPrimaryColor),
    );
  }
}
