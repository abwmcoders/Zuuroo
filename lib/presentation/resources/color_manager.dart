import 'package:flutter/material.dart';

class ColorManager {
  static Color scaffoldBg = HexColor.fromHex("#EFEBEA");
  static Color primaryColor = HexColor.fromHex("#F772D1");
  static Color secondaryColor = HexColor.fromHex("#643D90");
  static Color activeColor = HexColor.fromHex("#009A49");
  static Color pendColor = HexColor.fromHex("#C6B943");
  static Color greyColor = HexColor.fromHex("#BBBBBB");
  static Color deepGreyColor = HexColor.fromHex("#727272");
  static Color selectColor = HexColor.fromHex("#1752EA");
  static Color errorColor = HexColor.fromHex("##DB0808");
  static Color whiteColor = HexColor.fromHex("#FFFFFF");
  static Color blackColor = HexColor.fromHex("#121212");

  static LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      HexColor.fromHex("#F772D1"),
      HexColor.fromHex("#643D90"),
    ],
  );
  static LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      HexColor.fromHex("#F772D1"),
      HexColor.fromHex("#643D90"),
    ],
  );
  static LinearGradient homeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      HexColor.fromHex("#F772D1"),
      HexColor.fromHex("#643D90"),
    ],
  );
  static LinearGradient buttonFadeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      primaryColor.withOpacity(.4),
      secondaryColor.withOpacity(.4),
    ],
  );
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(
      int.parse(hexColorString, radix: 16),
    );
  }
}
