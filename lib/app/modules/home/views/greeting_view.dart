import 'package:flutter/material.dart';

class GreetingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi there",
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          "Welcome to Restaurant Catalogue App",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
