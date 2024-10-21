// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zuuro/presentation/resources/resources.dart';

import '../../../../../app/animation/navigator.dart';
import '../../../../../app/base/base_view_model/base_vm.dart';
import '../../../../../app/cache/orage_cred.dart';
import '../../../../../app/cache/storage.dart';
import '../../../../../app/functions.dart';
import '../repository/login_repo.dart';

class LoginProvider extends BaseViewModel {
  BuildContext? context;
  bool callInit;
  final TextEditingController? mekMail;

  final MekStorage? mekStorage;

  LoginProvider({
    this.context,
    this.callInit = false,
    this.mekMail,
    this.mekStorage,
  });

  //populate  loginTextField with  cache to validate fingerPrint

  populateLoginTextFields() async {
    String? emailFromStorage =
        await MekSecureStorage().getSecuredKeyStoreData(StorageKeys.emailKey);
    mekMail!.text = emailFromStorage ?? "";
  }

  void loginUser(
      {required BuildContext context,
      required TextEditingController password}) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    try {
      var request = await LoginRepository().loginUser(
        email: mekMail!.text.toString(),
        password: password.text.toString(),
      );
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          MekSecureStorage().storeByKey(StorageKeys.token, request['token']);
          MekSecureStorage().storeByKey(
              StorageKeys.emailKey, mekMail!.text.trim().toString());
          mekStorage!.putString(
            StorageKeys.onBoardingStorageKey,
            "used",
          );
          NavigateClass().pushNamed(
            context: context,
            routName: Routes.mainRoute,
          );
          mekMail!.clear();
          password.clear();
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
        message: "An error occurred, please try again later",
      );
    }
  }

  @override
  FutureOr<void> disposeState() {}

  @override
  FutureOr<void> initState() {
    populateLoginTextFields();
  }
}
