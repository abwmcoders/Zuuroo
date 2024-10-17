import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_view_model/base_vm.dart';

import '../../../../../app/animation/navigator.dart';
import '../../../../../app/functions.dart';
import '../../../../resources/resources.dart';
import '../repository/verify_repo.dart';

class VerifyProvider extends BaseViewModel {
  BuildContext? context;
  String? email;

  VerifyProvider({
    this.context,
    this.email,
  });

  //!------
  final otpField = TextEditingController();
  final otpFieldKey = GlobalKey<FormState>();



  @override
  void init() {
    super.init();
  }

  void verifyMail({required BuildContext context}) async {
    dismissKeyboard(context);
    final valid = otpFieldKey.currentState!.validate();
    if (!valid) return;

    changeLoaderStatus(true);
    try {
      var request = await VerifyRepository().verifyEmail(
        email: email,
        otp: otpField.text.trim().toString(),
      );

      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          NavigateClass().pushNamed(
            context: context,
            routName: Routes.loginRoute,
          );
          otpField.clear();
        } else {
          MekNotification().showMessage(
            context,
            message: request['message'].toString(),
          );
        }
      } else {
        MekNotification().showMessage(
          context,
          message: request['message'].toString(),
        );
      }
    } catch (e) {
      MekNotification().showMessage(
        context,
        message: e.toString(),
      );
    }
  }

  @override
  FutureOr<void> disposeState() {}

  @override
  FutureOr<void> initState() {}
}
