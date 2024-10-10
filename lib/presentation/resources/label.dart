import 'package:flutter/material.dart';

import 'resources.dart';

class Label extends StatelessWidget {
  final String? label;
  const Label({this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        label!,
        style: TextStyle(
          fontFamily: "NT",
          fontWeight: FontWeight.bold,
          color: Color(0xFF0D1B1E).withOpacity(0.78),
          fontSize: screenAwareSize(25, context),
        ),
      ),
    );
  }
}
