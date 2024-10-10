import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_view_model/base_vm.dart';
import 'package:zuuro/presentation/resources/resources.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/cache/storage.dart';
import '../../../../app/functions.dart';
import '../../../../app/locator.dart';
import '../../../../app/services/api_rep/user_services.dart';
import '../../../resources/routes_manager.dart';

class SettingsProvider extends BaseViewModel {
  //! provider varianbles
  BuildContext context;

  SettingsProvider({
    required this.context,
  });

  //! ---------------- -------------------

  String? otp;
  bool isPinCompleted = false;
  String? newPin;

  setNewPin(String pin) {
    newPin = pin;
    notifyListeners();
  }

  setBoolStatus(bool status) {
    isPinCompleted = status;
    notifyListeners();
  }

  setPin(String pin) {
    otp = pin;
    notifyListeners();
  }

  void changePassword({
    required BuildContext ctx,
    required String newPassword,
  }) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "password": newPassword,
      "password_confirmation": newPassword,
    };

    print("object for airtime purchase ---> $body");
    try {
      var request = await UserApiServices().changePassword(body);
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          final storageService = getIt<MekStorage>();
          storageService.clear();
          NavigateClass().pushNamed(
            context: ctx,
            routName: Routes.loginRoute,
          );
          MekNotification().showMessage(
            ctx,
            message: request['message'].toString() + "KIndly re-login....",
            color: ColorManager.activeColor,
          );
        } else {
          MekNotification().showMessage(
            ctx,
            message: request['message'].toString(),
          );
        }
      } else {
        MekNotification().showMessage(
          ctx,
          message: request['message'].toString(),
        );
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: e.toString(),
      );
    }
  }

  void changePin({
    required BuildContext ctx,
  }) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {"pin": newPin, "pin_confirmation": newPin};

    print("object for airtime purchase ---> $body");
    try {
      var request = await UserApiServices().changePin(body);
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          NavigateClass().pushNamed(
            context: ctx,
            routName: Routes.mainRoute,
          );
          MekNotification().showMessage(
            ctx,
            message: request['message'].toString(),
            color: ColorManager.activeColor,
          );
        } else {
          MekNotification().showMessage(
            ctx,
            message: request['message'].toString(),
          );
        }
      } else {
        MekNotification().showMessage(
          ctx,
          message: request['message'].toString(),
        );
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: e.toString(),
      );
    }
  }

  void verifyPin(
      {required BuildContext ctx,
      }) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "pin": otp,
    };

    try {
      var request = await UserApiServices().verifyPin(body);
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          changePin(ctx: ctx,);
        } else {
          MekNotification().showMessage(
            ctx,
            message: request['message'].toString(),
          );
        }
      } else {
        MekNotification().showMessage(
          ctx,
          message: request['message'].toString(),
        );
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: e.toString(),
      );
    }
  }

  //!============= ========
  @override
  FutureOr<void> disposeState() {}

  @override
  FutureOr<void> initState() {}
}
