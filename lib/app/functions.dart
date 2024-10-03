import 'package:flutter/material.dart';
import 'package:zuuro/presentation/resources/resources.dart';

class MekNotification {
  showMessage(BuildContext context, {required String message}) {
    final snackBar = SnackBar(
      backgroundColor: ColorManager.errorColor,
      content: Text(
        message,
        style: TextStyle(
            fontFamily: "MT",
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: ColorManager.whiteColor),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
