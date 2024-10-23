// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zuuro/app/app_constants.dart';
import 'package:zuuro/app/base/base_view_model/base_vm.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/resources/style_manager.dart';
import 'package:zuuro/presentation/view/home/model/loan_model.dart';
import 'package:zuuro/presentation/view/vtu/model/biller_model.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/functions.dart';
import '../../../../app/services/api_rep/user_services.dart';
import '../model/country_model.dart';
import '../model/data_cat_model.dart';
import '../model/data_plan_model.dart';
import '../model/meter_number_model.dart';
import '../model/operator_model.dart';

class VtuProvider extends BaseViewModel {
  BuildContext? context;
  List<CountryModel>? countries;
  dynamic operators;
  CountryModel? selectedCountry;
  BillerData? selectedBiller;
  bool shouldCallInit = false;
  bool callBiller = false;

  VtuProvider({
    this.context,
    this.countries,
    this.operators,
    this.selectedCountry,
    this.shouldCallInit = true,
    this.callBiller = false,
  });

  // TextEditingController amountController = TextEditingController();
  // TextEditingController numberController = TextEditingController();

  String? countryCode;
  String? billerCode;
  String? customerName;
  String? customerNumber;
  String? billerName;
  String? phoneCode;
  String? operatorCode;
  bool operatorSet = false;
  String? otp;
  String? metr;
  int currentPage = 0;
  int? selectedLoanIndex;
  bool isOtpComplete = false;
  final otpField = TextEditingController();
  TextEditingController amountController = TextEditingController(text: "");
  TextEditingController numberController = TextEditingController(text: "");
  TextEditingController meterNumber = TextEditingController();
  LoanLimit? loanLimit;
  DataCategory? selectedDataCat;
  DataPlan? selectedDataPlan;
  bool checkNumber = false;

  setIndex(int ind) {
    currentPage = ind;
    notifyListeners();
  }

  setCheckNumber(bool state) {
    checkNumber = state;
    notifyListeners();
  }

  setDataCat(DataCategory cat) {
    selectedDataCat = cat;
    notifyListeners();
  }

  setDataPlan(DataPlan plan) {
    selectedDataPlan = plan;
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

  setBool(bool asking) {
    isOtpComplete = asking;
    notifyListeners();
  }

  final List<Map> meterType = [
    {
      'id': 1,
      'name': 'Prepaid',
    },
    {
      'id': 2,
      'name': 'Postpaid',
    }
  ];

  setCountryCode(String newCode, String newPhoneCode) {
    countryCode = newCode;
    phoneCode = newPhoneCode;
    notifyListeners();
  }

  setBillerCode(String newCode, String newName) {
    billerCode = newCode;
    billerName = newName;
    notifyListeners();
  }

  setCustomerName(String name, String number) {
    customerName = name;
    customerNumber = number;
    notifyListeners();
  }

  setOtp(String newOtp) {
    otp = newOtp;
    notifyListeners();
  }

  setMeter(String newMeter) {
    metr = newMeter;
    notifyListeners();
  }

  setOperatorCode(code) {
    operatorCode = code;
    notifyListeners();
  }

  isOpSet() {
    operatorSet = true;
    notifyListeners();
  }

  List<DropdownMenuItem<CountryModel>> countryList(List<CountryModel> ct) {
    return ct
        .map(
          (value) => DropdownMenuItem<CountryModel>(
            value: value,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: value.countryName,
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

  List<DropdownMenuItem<BillerData>> billersCode(List<BillerData> ct) {
    return ct
        .map(
          (value) => DropdownMenuItem<BillerData>(
            value: value,
            child: Text(
              overflow: TextOverflow.ellipsis,
              value.billerName,
              softWrap: true,
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: 14,
              ),
            ),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<Map<dynamic, dynamic>>> meterTypeList() {
    return meterType
        .map(
          (value) => DropdownMenuItem<Map<dynamic, dynamic>>(
            value: value,
            child: Text(
              value["name"],
              softWrap: true,
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: 14,
              ),
            ),
          ),
        )
        .toList();
  }

  getData() async {
    final response = await UserApiServices().getCountryList();
    if (response != null && response['data'] != null) {
      List<CountryModel> _countryResult = AppConstants.countryModel ?? [];
      for (dynamic country in response['data']) {
        final countryModel = CountryModel.fromJson(country);
        bool exists = _countryResult.any((existingCountry) =>
            existingCountry.countryCode == countryModel.countryCode);

        if (!exists) {
          _countryResult.add(countryModel);
        }

        AppConstants.countryModel = _countryResult;
        notifyListeners();
      }
    }
  }

  getBiller() async {
    final response = await UserApiServices().getBillerList();
    if (response != null && response['data'] != null) {
      List<BillerData> _billerResult = AppConstants.billerModel ?? [];
      for (dynamic biller in response['data']) {
        final billerModel = BillerData.fromJson(biller);
        bool exists = _billerResult.any((existingBiller) =>
            existingBiller.billerCode == billerModel.billerCode);
        if (!exists) {
          _billerResult.add(billerModel);
        }
        AppConstants.billerModel = _billerResult;
        notifyListeners();
      }
    }
  }

  getOperator(String code) async {
    final response = await UserApiServices().getOperatorList(code);
    if (response != null) {
      List<OperatorModel> _operatorsResults = AppConstants.operatorModel ?? [];
      for (dynamic operator in response['data']) {
        final operators = OperatorModel.fromJson(operator);
        bool exists = _operatorsResults.any((existingOperator) =>
            existingOperator.operatorCode == operators.operatorCode);
        if (!exists) {
          _operatorsResults.add(
            OperatorModel.fromJson(operator),
          );
        }

        AppConstants.operatorModel = _operatorsResults;
        notifyListeners();
      }
    }
  }

  getDataCategory(String code) async {
    final response = await UserApiServices().getDataCatList(code);
    if (response != null) {
      List<DataCategory> _operatorsResults = [];
      for (dynamic operator in response['data']) {
        final operators = DataCategory.fromJson(operator);
        bool exists = _operatorsResults.any((existingOperator) =>
            existingOperator.operatorCode == operators.operatorCode);
        if (!exists) {
          _operatorsResults.add(
            DataCategory.fromJson(operator),
          );
        }
        AppConstants.dataCategoryModel = _operatorsResults;
        notifyListeners();
      }
    }
  }

  getDataPlan(String operatorCode, categoryCode) async {
    final response = await UserApiServices().getDataPlanList({
      "operator_code": operatorCode,
      "category_code": categoryCode,
    });
    if (response != null) {
      List<DataPlan> _operatorsResults = [];
      for (dynamic operator in response['data']) {
        final operators = DataPlan.fromJson(operator);
        bool exists = _operatorsResults.any((existingOperator) =>
            existingOperator.operatorCode == operators.operatorCode);
        if (!exists) {
          _operatorsResults.add(
            DataPlan.fromJson(operator),
          );
        }
        AppConstants.dataPlanModel = _operatorsResults;
        notifyListeners();
      }
    }
  }

  void purchaseAirtime(
      {required BuildContext ctx,
      int topUp = 1,
      required String amount}) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "pin": otp,
      "top_up": topUp,
      "country": countryCode,
      "phoneNumber": numberController.text.trim(),
      "network_operator":
          operatorCode ?? AppConstants.operatorModel![0].operatorCode,
      "amount": amount,
    };

    print("object for airtime purchase ---> $body");
    try {
      var request = await UserApiServices().purchaseAirtime(body);
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          NavigateClass().pushNamed(
            context: ctx,
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

  void purchaseData({
    required BuildContext ctx,
    int topUp = 1,
    required String pin,
  }) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "pin": pin,
      "top_up": topUp,
      "country": countryCode,
      "phoneNumber": numberController.text.trim(),
      "network_operator":
          operatorCode ?? AppConstants.operatorModel![0].operatorCode,
      "data_plan": selectedDataPlan!.productCode,
    };

    print("object for data purchase ---> $body");
    try {
      var request = await UserApiServices().purchaseData(body);
      print("response for data purchase ---> $request");
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          NavigateClass().pushNamed(
            context: ctx,
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
          message: "An error occurred, Please check your internet connection",
        );
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: "An error occurred, Please try again later",
      );
    }
  }

  void purchaseBill(
      {required BuildContext ctx,
      required String meterNumber,
      required String pin,
      int topUp = 1,
      required String amount}) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "billerName": billerCode,
      "meterType": metr,
      "top_up": topUp,
      "meterNumber": meterNumber,
      "amount": amount,
      "customerName": customerName,
      "customerPhoneNumber": numberController.text.trim(),
      "pin": pin,
    };

    print("object for airtime purchase ---> $body");
    try {
      var request = await UserApiServices().purchaseBill(body);
      changeLoaderStatus(false);
      if (request != null) {
        if (request["status"] == true) {
          NavigateClass().pushNamed(
            context: ctx,
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

  void verifyPin({
    required BuildContext ctx,
    required Function onSuccess,
    Function? onError,
  }) async {
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

  Future<VerifyMeterNumberData?> verifyMeterNumber({
    required BuildContext ctx,
    required String ctr,
    required String billerCode,
    String meterType = "prepaid",
  }) async {
    dismissKeyboard(context);
    var body = {
      "serviceID": ctr,
      "billersCode": billerCode,
      "meterType": meterType,
    };

    try {
      var request = await UserApiServices().verifyMeterNumber(body);
      if (request != null) {
        if (request["success"] == true) {
          var verifyMeterResponse =
              VerifyMeterNumberData.fromJson(request['data']);
          return verifyMeterResponse;
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
          message: request['message'].toString(),
        );
        return null;
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: e.toString(),
      );
      return null;
    }
  }

  void setSelectedCountry(CountryModel country) {
    selectedCountry = country;
    notifyListeners();
  }

  void setSelectedBiller(BillerData biller) {
    selectedBiller = biller;
    notifyListeners();
  }

  @override
  FutureOr<void> disposeState() {}

  @override
  FutureOr<void> initState() async {
    if (callBiller) {
      await getBiller();
    }
    if (countries == null || AppConstants.countryModel == null) {
      if (shouldCallInit) {
        changeCallInitState(false);
        await getData();
      }
    }
  }

  changeCallInitState(bool state) {
    shouldCallInit = state;
    notifyListeners();
  }
}
