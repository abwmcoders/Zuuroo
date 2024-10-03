import 'package:flutter/material.dart';

import 'resources.dart';

class Styles {
  static const TextStyle kSmallTextStyle =
      TextStyle(fontFamily: "NT", fontSize: UIHelper.smallfontSize);
  static const TextStyle kLargeTextStyle =
      TextStyle(fontFamily: "NT", fontSize: UIHelper.largefontSize);
  static const TextStyle kMediumTextStyle =
      TextStyle(fontFamily: "NT", fontSize: UIHelper.mediumfontSize);
  static final kRedTextFieldStyling = OutlineInputBorder(
    borderRadius: kTextFieldBorder,
    borderSide: BorderSide(color: ColorManager.errorColor),
  );

  static OutlineInputBorder kYellowTextFieldStyling = OutlineInputBorder(
      borderRadius: kTextFieldBorder,
      borderSide: BorderSide(color: ColorManager.pendColor));
  static OutlineInputBorder kTextFieldBlackStyling = const OutlineInputBorder(
    gapPadding: 0.0,
    borderRadius: kTextFieldBorder,
    borderSide: BorderSide(
      width: 0,
      color: Colors.transparent,
    ),
  );
  static const kTextFieldBorder = BorderRadius.all(
    Radius.circular(10),
  );
}

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

//! regular style
TextStyle getRegularStyle(
    {double fontSize = UIHelper.mediumfontSize, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.regular,
    color,
  );
}

//! light text style
TextStyle getLightStyle(
    {double fontSize = UIHelper.mediumfontSize, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.light,
    color,
  );
}

//! bold text style
TextStyle getBoldStyle(
    {double fontSize = UIHelper.mediumfontSize, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.bold,
    color,
  );
}

//! semi bold text style
TextStyle getSemiBoldStyle(
    {double fontSize = UIHelper.mediumfontSize, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.semiBold,
    color,
  );
}

// medium text style

TextStyle getMediumStyle(
    {double fontSize = UIHelper.mediumfontSize, required Color color}) {
  return _getTextStyle(
    fontSize,
    FontConstants.fontFamily,
    FontWeightManager.medium,
    color,
  );
}
