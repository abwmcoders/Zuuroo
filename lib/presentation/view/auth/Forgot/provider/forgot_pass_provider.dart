import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_view_model/base_vm.dart';

import '../../../../../app/animation/navigator.dart';
import '../../../../../app/functions.dart';
import '../../../../resources/resources.dart';
import '../model/forget_model.dart';
import '../repository/forgot_repo.dart';

class ForgetPasswordProvider extends BaseViewModel {
  //! ------------ provider variables --------
  BuildContext? context;

  ForgetPasswordProvider({
    this.context,
    this.pageController,
  });

  //! -------------other variables ------------
  PageController? pageController;
  int pageIndex = 0;
  String? email;
  String? otp;

  setIndex({required int result, required int value}) {
    value = result;
    notifyListeners();
  }

  updatePage() {
    pageIndex++;
    notifyListeners();
  }

  setEmail(String mail) {
    email = mail;
    notifyListeners();
  }

  setOtp(String code) {
    otp = code;
    notifyListeners();
  }

  void resetPassword(
      {required BuildContext ctx, required String password}) async {
    dismissKeyboard(ctx);
    changeLoaderStatus(true);
    ForgetPasswordModel body = ForgetPasswordModel(
      email: email!,
      otp: otp!,
      password: password,
    );
    try {
      var request = await ForgotPasswordRepository().resetPassword(body);
      print("response reg ------->$request");
      changeLoaderStatus(false);
      if (kDebugMode) {
        print(request.toString());
      }
      if (request != null) {
        if (request['status'] == true) {
          NavigateClass().pushNamed(
            context: ctx,
            routName: Routes.loginRoute,
          );
          MekNotification().showMessage(
            context!,
            color: ColorManager.activeColor,
            message: request['message'].toString(),
          );
        } else {
          MekNotification().showMessage(
            context!,
            message: request['message'].toString(),
          );
        }
      }
    } catch (e) {
      // show error snackbar or notify user of the error
      if (kDebugMode) {
        print(e.toString());
        MekNotification().showMessage(
          context!,
          message: e.toString(),
        );
      }
    }
  }

  Future<bool> requestReset({required BuildContext ctx}) async {
    dismissKeyboard(ctx);
    changeLoaderStatus(true);
    var body = {
      "email": email,
    };
    try {
      var request = await ForgotPasswordRepository().requestReset(body);
      changeLoaderStatus(false);
      if (request != null) {
        if (request['status'] == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      // show error snackbar or notify user of the error
      if (kDebugMode) {
        print(e.toString());
        MekNotification().showMessage(
          context!,
          message: e.toString(),
        );
      }
      return false;
    }
  }

  //!----------------
  @override
  FutureOr<void> disposeState() {
    pageController!.dispose();
  }

  @override
  FutureOr<void> initState() {
    pageController = PageController(initialPage: 0);
  }
}
