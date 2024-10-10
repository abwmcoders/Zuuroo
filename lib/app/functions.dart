import 'package:flutter/material.dart';
import 'package:zuuro/presentation/resources/resources.dart';

class MekNotification {
  showMessage(BuildContext context, {required String message, Color? color}) {
    final snackBar = SnackBar(
      backgroundColor: color ?? ColorManager.errorColor,
      content: Text(
        message,
        style: TextStyle(
            fontFamily: "NT",
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: ColorManager.whiteColor,),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
