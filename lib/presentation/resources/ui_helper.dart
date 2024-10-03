// Contains useful consts to reduce boilerplate and duplicate code
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class UIHelper {

  //! Fonts size constants
  static const double smallfontSize = 11.0;
  static const double elevation = 5.0;
  static const double smallRadius = 10.0;
  static const double mediumfontSize = 15.0;
  static const double largefontSize = 24.0;
  static const double mediumPlusfontSize = 18.0;
  static const double smallIconsSize = 15.0;

  //! Vertical spacing constants. Adjust to your liking.
  static const double _VerticalSpaceLittle = 5.0;
  static const double _VerticalSpaceSmall = 10.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpaceMediumPlus = 30.0;
  static const double _VerticalSpaceLarge = 40.0;

  //! Horizontal spacing constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpaceLarge = 30.0;

  static const Widget verticalSpaceLittle =
      SizedBox(height: _VerticalSpaceLittle);
  static const Widget verticalSpaceSmall =
      SizedBox(height: _VerticalSpaceSmall);
  static const Widget verticalSpaceMedium =
      SizedBox(height: _VerticalSpaceMedium);
  static const Widget verticalSpaceMediumPlus =
      SizedBox(height: _VerticalSpaceMediumPlus);
  static const Widget verticalSpaceLarge =
      SizedBox(height: _VerticalSpaceLarge);

  static const Widget horizontalSpaceSmall =
      SizedBox(width: _HorizontalSpaceSmall);
  static const Widget horizontalSpaceMedium =
      SizedBox(width: _HorizontalSpaceMedium);
  static const Widget horizontalSpaceLarge =
      SizedBox(width: _HorizontalSpaceLarge);
}

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenAwareSize(double value, BuildContext context,
    {bool width = false}) {
  if (width) {
    return MediaQuery.of(context).size.width * (value / 414);
  } else {
    return MediaQuery.of(context).size.height * (value / 1181);
  }
}
