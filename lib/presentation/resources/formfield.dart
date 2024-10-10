import 'package:flutter/material.dart';

import 'resources.dart';

class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    this.onChanged,
    this.fieldController,
    required this.hintText,
    this.prefix,
    this.suffix,
    this.labelColor,
    this.onSaved,
    this.onEditingComplete,
    this.hintTextStyle,
    this.validator,
    this.shouldBeWhite,
    this.letterSpacing = 1.5,
    this.suffixWidget,
    this.obscure,
    this.obscureCharacter = "●",
    this.keyboardType,
  });

  final Function(String)? onChanged;
  final TextEditingController? fieldController;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final Color? labelColor;
  final Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  final TextStyle? hintTextStyle;
  final String? Function(String?)? validator;
  final bool? shouldBeWhite;
  final double? letterSpacing;
  final Widget? suffixWidget;
  final bool? obscure;
  final String obscureCharacter;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.only(left: screenAwareSize(5, context)),
          border: Styles.kTextFieldBlackStyling,
          focusedBorder: Styles.kTextFieldBlackStyling,
          enabledBorder: Styles.kTextFieldBlackStyling,
          errorBorder: Styles.kRedTextFieldStyling,
          focusedErrorBorder: Styles.kRedTextFieldStyling,
        ),
      ),
      child: TextFormField(
        scrollPadding: EdgeInsets.zero,
        obscuringCharacter: obscureCharacter,
        cursorWidth: 0.9,
        cursorColor: ColorManager.primaryColor,
        cursorHeight: screenAwareSize(25, context),
        controller: fieldController,
        style: TextStyle(
          fontSize: UIHelper.smallIconsSize,
          fontWeight: FontWeight.normal,
          letterSpacing: letterSpacing,
          fontFamily: "NT",
        ),
        keyboardType: keyboardType ?? TextInputType.number,
        onChanged: onChanged,
        autocorrect: false,
        validator: validator,
        obscureText: obscure ?? false,
        onEditingComplete: onEditingComplete,
        onSaved: onSaved,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          fillColor: ColorManager.whiteColor.withOpacity(.6),
          filled: true,
          border: OutlineInputBorder(
            gapPadding: 1.0,
            borderRadius: BorderRadius.circular(50),
          ),
           suffixIcon: suffixWidget ?? const Text(""),
          //prefixIcon: prefix ?? const Text(""),
         // suffix: suffix ?? const Text(""),
          hintText: hintText,
          errorStyle: Styles.kSmallTextStyle.copyWith(
            color: ColorManager.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: hintTextStyle,
        ),
      ),
    );
  }
}

class RectangularTextFormField extends StatelessWidget {
  const RectangularTextFormField({
    super.key,
    this.onChanged,
    this.fieldController,
    required this.hintText,
    this.prefix,
    this.suffix,
    this.labelColor,
    this.onSaved,
    this.onEditingComplete,
    this.hintTextStyle,
    this.validator,
    this.shouldBeWhite,
    this.letterSpacing = 1.5,
    this.suffixWidget,
    this.obscure,
    this.obscureCharacter = "●",
    this.keyboardType,
  });

  final Function(String)? onChanged;
  final TextEditingController? fieldController;
  final String? hintText;
  final Widget? prefix;
  final Widget? suffix;
  final Color? labelColor;
  final Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  final TextStyle? hintTextStyle;
  final String? Function(String?)? validator;
  final bool? shouldBeWhite;
  final double? letterSpacing;
  final Widget? suffixWidget;
  final bool? obscure;
  final String obscureCharacter;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.greyColor.withOpacity(.14),
            spreadRadius: 8,
            blurRadius: 9,
            offset: const Offset(8, 5), // changes position of shadow
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.only(left: screenAwareSize(20, context)),
            border: Styles.kTextFieldBlackStyling,
            focusedBorder: Styles.kTextFieldBlackStyling,
            enabledBorder: Styles.kTextFieldBlackStyling,
            errorBorder: Styles.kRedTextFieldStyling,
            focusedErrorBorder: Styles.kTextFieldBlackStyling,
          ),
        ),
        child: TextFormField(
          scrollPadding: EdgeInsets.zero,
          obscuringCharacter: obscureCharacter,
          cursorWidth: 0.8,
          cursorColor: ColorManager.primaryColor,
          cursorHeight: screenAwareSize(25, context),
          controller: fieldController,
          style: TextStyle(
            fontSize: UIHelper.mediumfontSize,
            fontWeight: FontWeight.bold,
            letterSpacing: letterSpacing,
            fontFamily: "MT",
          ),
          keyboardType: keyboardType ?? TextInputType.number,
          onChanged: onChanged,
          autocorrect: false,
          validator: validator,
          obscureText: obscure ?? false,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            fillColor: ColorManager.whiteColor,
            filled: true,
            border: OutlineInputBorder(
              gapPadding: 1.0,
              borderRadius: BorderRadius.circular(1),
            ),
            suffixIcon: suffixWidget ?? const Text(""),
            prefixIcon: prefix ?? const Text(""),
            suffix: suffix ?? const Text(""),
            hintText: hintText,
            errorStyle: Styles.kSmallTextStyle.copyWith(
              color: ColorManager.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            hintStyle: hintTextStyle,
          ),
        ),
      ),
    );
  }
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 10),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.transparent),
  );
}


