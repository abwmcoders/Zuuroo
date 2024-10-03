import 'package:flutter/material.dart';

import 'resources.dart';


ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: FontConstants.fontFamily,
    scaffoldBackgroundColor: ColorManager.scaffoldBg,
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.primaryColor.withOpacity(.4),
    primaryColorDark: ColorManager.primaryColor,
    disabledColor: ColorManager.greyColor,
    // ripple color
    splashColor: ColorManager.primaryColor,
    // will be used incase of disabled button for example
    hintColor: ColorManager.greyColor,
    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.greyColor,
      elevation: UIHelper.elevation,
    ),
    // App bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.greyColor,
        elevation: UIHelper.elevation,
        shadowColor: ColorManager.greyColor,
        titleTextStyle:
            getRegularStyle(color: ColorManager.whiteColor, fontSize: UIHelper.mediumfontSize,),),
    // Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.greyColor,
      buttonColor: ColorManager.primaryColor,
      splashColor: ColorManager.primaryColor,
    ),

    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(color: ColorManager.whiteColor),
            backgroundColor: ColorManager.primaryColor.withOpacity(.4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(UIHelper.smallRadius)))),

    // Text theme
    textTheme: TextTheme(
      // displayLarge: getSemiBoldStyle(
      //   color: ColorManager.darkGrey,
      //   fontSize: UIHelper.mediumPlusfontSize,
      // ),
      // displayMedium: getRegularStyle(
      //   color: ColorManager.white,
      //   fontSize: FontSize.s16,
      // ),
      // displaySmall: getBoldStyle(
      //   color: ColorManager.primary,
      //   fontSize: FontSize.s16,
      // ),
      // headlineMedium: getRegularStyle(
      //   color: ColorManager.primary,
      //   fontSize: FontSize.s14,
      // ),
      // titleMedium: getMediumStyle(
      //   color: ColorManager.lightGrey,
      //   fontSize: FontSize.s14,
      // ),
      // titleSmall: getMediumStyle(
      //   color: ColorManager.primary,
      //   fontSize: FontSize.s14,
      // ),
      bodyMedium: getMediumStyle(color: ColorManager.primaryColor),
      bodySmall: getRegularStyle(color: ColorManager.primaryColor),
      bodyLarge: getRegularStyle(color: ColorManager.primaryColor),
    ),
    // input decoration theme (text form field)
//TODO: Adjust if need be
    // inputDecorationTheme: InputDecorationTheme(
    //   contentPadding: const EdgeInsets.all(AppPadding.p8),
    //   // hint style
    //   hintStyle: getRegularStyle(color: ColorManager.grey1),

    //   // label style
    //   labelStyle: getMediumStyle(color: ColorManager.darkGrey),
    //   // error style
    //   errorStyle: getRegularStyle(color: ColorManager.error),

    //   // enabled border
    //   enabledBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: ColorManager.grey,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: const BorderRadius.all(
    //       Radius.circular(AppSize.s8),
    //     ),
    //   ),

    //   // focused border
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: ColorManager.primary,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: const BorderRadius.all(
    //       Radius.circular(AppSize.s8),
    //     ),
    //   ),

    //   // error border
    //   errorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: ColorManager.error,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: const BorderRadius.all(
    //       Radius.circular(AppSize.s8),
    //     ),
    //   ),
    //   // focused error border
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderSide: BorderSide(
    //       color: ColorManager.primary,
    //       width: AppSize.s1_5,
    //     ),
    //     borderRadius: const BorderRadius.all(
    //       Radius.circular(AppSize.s8),
    //     ),
    //   ),
    // ),
  );
}
