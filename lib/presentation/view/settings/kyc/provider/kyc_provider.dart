import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_view_model/base_vm.dart';
import 'package:zuuro/presentation/resources/resources.dart';

import '../../../../../app/functions.dart';
import '../model/kyc_model.dart';
import '../repository/kyc_repo.dart';

class KycProvider extends BaseViewModel {
  BuildContext? context;

  KycProvider({
    this.context,
  });

  //!------------------ kyc verification ----------------------

  void verifyKyc({required KycModel kyc}) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    try {
      var request = await KycRepository().kyc(verify: kyc);
      changeLoaderStatus(false);
      if (request != null) {
        if (request["success"] == true) {
          Navigator.pop(context!);
         MekNotification().showMessage(
            context!,
            color: ColorManager.activeColor,
            message: request['message'].toString(),
          );
        } else if(request['message'] == "KYC Already Exist !!!") {
          Navigator.pop(context!);
          MekNotification().showMessage(
            context!,
            color: ColorManager.activeColor,
            message: request['message'].toString(),
          );
        }
        else {
          MekNotification().showMessage(
            context!,
            message: request['message'].toString(),
          );
        }
      } else {
        MekNotification().showMessage(
        context!,
          message: "An error occurred, please check your internet connection",
        );
      }
    } catch (e) {
      MekNotification().showMessage(
        context!,
        message: "An error occurred, please try again later",
      );
    }
  }

  @override
  FutureOr<void> disposeState() {}

  @override
  FutureOr<void> initState() {}
}
