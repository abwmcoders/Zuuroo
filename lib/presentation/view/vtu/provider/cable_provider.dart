import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_view_model/base_vm.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/app_constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/services/api_rep/user_services.dart';
import '../../../resources/resources.dart';
import '../../home/model/loan_model.dart';
import '../model/cable_model.dart';
import '../model/cable_plan_model.dart';
import '../model/verify_iuc.dart';

class CableProvider extends BaseViewModel {
  BuildContext? context;

  CableProvider({
    this.context,
  });

  //! cable data
  CableData? selectedCable;
  List<CableData>? cables;
  String? cableCode;
  String? cableName;
  CablePlan? cablePlan;
  String? otp;
  bool planSet = false;
  String? customerName;
  String? customerNumber;
  IUCData? selectedIucNumber;

  //!-----
  int currentPage = 0;
  bool checkNumber = false;
  int? selectedLoanIndex;
  final otpField = TextEditingController();
  TextEditingController iucNumber = TextEditingController();
  TextEditingController number = TextEditingController();
  LoanLimit? loanLimit;

  setIndex(int ind) {
    currentPage = ind;
    notifyListeners();
  }

  setIucData(IUCData iuc) {
    selectedIucNumber = iuc;
    notifyListeners();
  }

  setCheckNumber(bool state) {
    checkNumber = state;
    notifyListeners();
  }

  setLoanLimit(LoanLimit limit) {
    loanLimit = limit;
    notifyListeners();
  }

  setLoanIndex(int ind) {
    if (selectedLoanIndex == ind) {
      selectedLoanIndex = null;
    } else {
      selectedLoanIndex = ind;
    }
    notifyListeners();
  }

  setString(String newCode, String newName) {
    cableCode = newCode;
    cableName = newName;
    notifyListeners();
    print("set fields s-----> $cableName ----- $cableCode");
  }

  setOtp(String newOtp) {
    otp = newOtp;
    notifyListeners();
  }

  setSelectedPlan(CablePlan plan) {
    cablePlan = plan;
    notifyListeners();
  }

  setSelectedCable(CableData cable) {
    selectedCable = cable;
    notifyListeners();
  }

  setPlan() {
    planSet = true;
    notifyListeners();
  }

  setCustomerName(String name, String number) {
    customerName = name;
    customerNumber = number;
    notifyListeners();
  }

  List<DropdownMenuItem<CableData>> cableList(List<CableData> ct) {
    return ct
        .map(
          (value) => DropdownMenuItem<CableData>(
            value: value,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value.providerName,
                    style: getBoldStyle(
                      color: ColorManager.blackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  getCables() async {
    final response = await UserApiServices().getCableList();
    if (response != null && response['data'] != null) {
      List<CableData> cableResult = AppConstants.cableModel ?? [];
      for (dynamic cable in response['data']) {
        final cableModel = CableData.fromJson(cable);
        bool exists = cableResult.any((existingCable) =>
            existingCable.providerCode == cableModel.providerCode);

        if (!exists) {
          cableResult.add(cableModel);
        }
        AppConstants.cableModel = cableResult;
        notifyListeners();
      }
    }
  }

  getCableplan(String code) async {
    final response = await UserApiServices().getCablePlan(code);
    print("Operator resoonse ---> $response");
    if (response != null) {
      List<CablePlan> _cablePlanResults = [];
      for (dynamic plan in response) {
        final cablePl = CablePlan.fromJson(plan);
        bool exists = _cablePlanResults
            .any((existingPlan) => existingPlan.plan == cablePl.plan);
        if (!exists) {
          _cablePlanResults.add(
            CablePlan.fromJson(plan),
          );
        }

        AppConstants.cablePlanModel = _cablePlanResults;
        notifyListeners();
      }
    }
  }

  verifyIucNumber({
    required BuildContext ctx,
    required String iuc,
  }) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {"iucNumber": iuc, "cableName": cableName};
    print("bode for verify ---> $body");
    try {
      var request = await UserApiServices().verifyIucNumber(body);
      
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == "true") {
          var iucResponse = IUCData.fromJson(request['data']);
          setIucData(iucResponse);
        } else {
          MekNotification().showMessage(
            ctx,
            message: request['message'].toString(),
          );
          return null;
        }
      } else {
        MekNotification().showMessage(
          ctx,
          message: "An error occurred, Please check your internet connection",
        );
        return null;
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: "An error occurred, Please try again later",
      );
      return null;
    }
  }

  void purchaseCable({
    required BuildContext ctx,
    required String iuc,
    required String amount,
    int topUp = 1,
  }) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "cableName": selectedCable!.providerCode,
      "cablePlan": cablePlan!.planId,
      "cableNumber": iuc,
      "amount": amount,
      "top_up": topUp,
      "customerName": selectedIucNumber!.name,
      "customerPhoneNumber": number.text.trim(),
      "pin": otpField.text.trim(),
    };

    print("object for cable purchase ---> $body");
    try {
      var request = await UserApiServices().purchaseCable(body);
      print("response for data purchase ---> $request");
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          NavigateClass().pushNamed(
            context: ctx,
            args: amount,
            routName: Routes.success,
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
      {required BuildContext ctx, required Function onSuccess}) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "pin": otpField.text.trim(),
    };

    try {
      var request = await UserApiServices().verifyPin(body);
      changeLoaderStatus(false);
      print("pin verification ---> $request");
      if (request != null) {
        if (request["status"] == true) {
          await onSuccess();
        } else {
          Navigator.pop(ctx);
          MekNotification().showMessage(
            ctx,
            message: request['message'].toString(),
          );
          otpField.clear();
        }
      } else {
        Navigator.pop(ctx);
        MekNotification().showMessage(
          ctx,
          message: request['message'].toString(),
        );
        otpField.clear();
      }
    } catch (e) {
      Navigator.pop(ctx);
      MekNotification().showMessage(
        ctx,
        message: "An error occurred, Please check your internet connection",
      );
      otpField.clear();
    }
  }

  @override
  FutureOr<void> disposeState() {}

  @override
  FutureOr<void> initState() async {
    if (cables != [] && AppConstants.cableModel!.isEmpty) {
      await getCables();
    } else {
      print("Cable already fetched");
    }
  }
}
