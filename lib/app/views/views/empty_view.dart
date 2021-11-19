import 'package:flutter/material.dart';
import 'package:restaurant_app/app/utils/dimen_constants.dart';

class EmptyView extends StatelessWidget {
  final String message;

  EmptyView({ required this.message });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(dimenMedium),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}