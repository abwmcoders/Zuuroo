import 'package:flutter/material.dart';

import 'resources.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.height,
    this.width,
    this.buttonTextColor = Colors.white,
    this.textStyle,
    this.borderColor,
  });

  final VoidCallback? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final Color buttonTextColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
       width: width ?? deviceWidth(context) / 1.05,
      height: height ?? screenAwareSize(96, context),
      decoration: BoxDecoration(
        gradient: ColorManager.buttonGradient,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderColor ?? Colors.transparent, width: 2
          )
      ),
      child: MaterialButton(
        elevation: 0,
        onPressed: onPressed,
        minWidth: width ?? deviceWidth(context) / 1.05,
        height: height ?? screenAwareSize(96, context),
        color: buttonColor ?? Colors.transparent,
        //disabledColor: ColorManager.greyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          buttonText,
          style: textStyle ??
              Styles.kMediumTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "NT",
                  color: buttonTextColor,
                  fontSize: screenAwareSize(27, context)),
        ),
      ),
    );
  }
}
