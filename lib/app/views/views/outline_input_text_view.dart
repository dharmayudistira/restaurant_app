import 'package:flutter/material.dart';
import 'package:restaurant_app/app/utils/color_constants.dart';

class OutlineInputTextView extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool needCounter;

  OutlineInputTextView({
    required this.labelText,
    required this.controller,
    required this.needCounter,
  });

  @override
  State<OutlineInputTextView> createState() => _OutlineInputTextViewState();
}

class _OutlineInputTextViewState extends State<OutlineInputTextView> {

  @override
  Widget build(BuildContext context) {

    var characterCount = widget.controller.text.length;

    return TextFormField(
      controller: widget.controller,
      cursorColor: kPrimaryColor,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
        counterText: (widget.needCounter) ? "counter: $characterCount" : '',
      ),
      onChanged: (value) {
        setState(() {
          characterCount = value.length;
        });
      },
    );
  }
}
