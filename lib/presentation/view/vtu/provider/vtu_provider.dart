// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:math';

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
import '../model/power_model.dart';

class VtuProvider extends BaseViewModel {
  BuildContext? context;
  List<CountryModel>? countries;
  dynamic operators;
  CountryModel? selectedCountry;
  CountryModel? selectedLoanCountry;
  PowerModel? selectedBiller;
  bool shouldCallInit = false;
  bool callBiller = false;

  VtuProvider({
    this.context,
    this.countries,
    this.operators,
    this.selectedCountry,
    this.selectedLoanCountry,
    this.shouldCallInit = true,
    this.callBiller = false,
  });

  // TextEditingController amountController = TextEditingController();
  // TextEditingController numberController = TextEditingController();

  String? countryCode;
  String? loanCountryCode;
  String? billerCode;
  String? customerName;
  String? customerNumber;
  String? billerName;
  String? phoneCode;
  String? loanPhoneCode;
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
  MeterModel? selectedMeterData;

  int toCeil(String number) {
    print("Inside to ceil ---> amount: $number");
    int roundedValue = double.parse(number).ceil();
    print("returning value ---> value: $roundedValue");
    return roundedValue;
  }

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

  setMeterData(MeterModel data) {
    selectedMeterData = data;
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

  setLoanCountryCode(String newCode, String newPhoneCode) {
    loanCountryCode = newCode;
    loanPhoneCode = newPhoneCode;
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
    print("countries ---> $response");
    if (response != null && response['data'] != null) {
      List<CountryModel> _countryResult = AppConstants.countryModel ?? [];
      for (dynamic country in response['data']) {
        final countryModel = CountryModel.fromJson(country);
        bool exists = _countryResult.any((existingCountry) => existingCountry.countryCode == countryModel.countryCode);

        if (!exists) {
          _countryResult.add(countryModel);
        }

        AppConstants.countryModel = _countryResult;
        notifyListeners();
      }
    }
  }

  getLoanCountry() async {
    final response = await UserApiServices().getLoanCountryList();
    print("countries ---> $response");
    if (response != null && response['data'] != null) {
      List<CountryModel> _countryResult = AppConstants.countryLoanModel ?? [];
      for (dynamic country in response['data']) {
        final countryModel = CountryModel.fromJson(country);
        bool exists = _countryResult.any((existingCountry) => existingCountry.countryCode == countryModel.countryCode);

        if (!exists) {
          _countryResult.add(countryModel);
        }

        AppConstants.countryLoanModel = _countryResult;
        notifyListeners();
      }
    }
  }

  getBiller() async {
    final response = await UserApiServices().getBillerList();
    if (response != null && response['data'] != null) {
      List<PowerModel> _billerResult = AppConstants.billerModel ?? [];
      for (dynamic biller in response['data']) {
        final billerModel = PowerModel.fromJson(biller);
        bool exists = _billerResult.any((existingBiller) => existingBiller.provider == billerModel.provider);
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
    print("operator fr country ---> $response");
    if (response != null) {
      List<OperatorModel> _operatorsResults = [];
      for (dynamic operator in response['data']) {
        final operators = OperatorModel.fromJson(operator);
        bool exists =
            _operatorsResults.any((existingOperator) => existingOperator.operatorCode == operators.operatorCode);
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
    print("data category ---> $response");
    if (response != null) {
      List<DataCategory> _operatorsResults = [];
      for (dynamic operator in response['data']) {
        // final operators = DataCategory.fromJson(operator);
        // bool exists = _operatorsResults.any((existingOperator) =>
        //     existingOperator.operatorCode == operators.operatorCode);
        // if (!exists) {
        _operatorsResults.add(
          DataCategory.fromJson(operator),
        );
        // }
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
    print("data plan ---> $response");
    if (response != null) {
      List<DataPlan> _operatorsResults = [];
      for (dynamic operator in response['data']) {
        // final operators = DataPlan.fromJson(operator);
        // bool exists = _operatorsResults.any((existingOperator) =>
        //     existingOperator.operatorCode == operators.operatorCode);
        //if (!exists) {
        _operatorsResults.add(
          DataPlan.fromJson(operator),
        );
        //}
        AppConstants.dataPlanModel = _operatorsResults;
        notifyListeners();
      }
    }
  }

  void purchaseAirtime({required BuildContext ctx, int topUp = 1, required String amount}) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "pin": otpField.text.trim(),
      "top_up": topUp,
      "country": topUp == 2 ? loanCountryCode : countryCode,
      "phoneNumber": numberController.text.trim(),
      "network_operator": operatorCode ?? AppConstants.operatorModel![0].operatorCode,
      "amount": amount,
    };

    print("object for airtime purchase ---> $body");
    try {
      var request = await UserApiServices().purchaseAirtime(body);
      changeLoaderStatus(false);
      print("response for purchase ---> $request");
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
      "country": topUp == 2 ? loanCountryCode : countryCode,
      "phoneNumber": numberController.text.trim(),
      "network_operator": operatorCode ?? AppConstants.operatorModel![0].operatorCode,
      "data_plan": selectedDataPlan!.productCode,
    };

    print("object for data purchase ---> $body");
    var request = await UserApiServices().purchaseData(body);
    print("response for data purchase ---> $request");
    changeLoaderStatus(false);
    if (request != null) {
      if (request["status"] == true) {
        NavigateClass().pushNamed(
          context: ctx,
          args: topUp == 1 ? selectedDataPlan!.productPrice.toString() : selectedDataPlan!.loanPrice.toString(),
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
  }

  void purchaseBill(
      {required BuildContext ctx,
      required String meterNumber,
      required String pin,
      int topUp = 1,
      required String amount}) async {
    print("called purchase bill");
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "provider": selectedBiller!.provider.toString(),
      "meterType": metr!.toLowerCase(),
      "top_up": topUp,
      "meterNumber": meterNumber,
      "reference": generateRandomReference(),
      "amount": amount,
      "customerName": selectedMeterData!.customerName,
      "customerPhoneNumber": numberController.text.trim(),
      "pin": pin,
    };

    print("body for bill purchase ---> $body");
    try {
      var request = await UserApiServices().purchaseBill(body);
      changeLoaderStatus(false);
      print("body for res bill purchase ---> $request");
      if (request != null) {
        if (request["success"] == true) {
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

    var request = await UserApiServices().verifyPin(body);
    changeLoaderStatus(false);
    print("pin verification ---> $request");
    if (request != null) {
      if (request["status"] == true) {
        onSuccess();
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
        message: "An error occurred, Please check your internet connection",
      );
      otpField.clear();
    }
  }

  verifyMeterNumber({
    required BuildContext ctx,
    required String ctr,
    required String billerCode,
    String meterType = "prepaid",
  }) async {
    dismissKeyboard(context);
    changeLoaderStatus(true);
    var body = {
      "number": ctr,
      "provider": billerCode,
      "type": meterType,
    };
    print("verify meter body ---> $body");

    try {
      var request = await UserApiServices().verifyMeterNumber(body);
      changeLoaderStatus(false);
      print("verify meter response ---> $request");
      if (request != null) {
        if (request["success"] == true) {
          var verifyMeterResponse = MeterModel.fromJson(request['data']);
          setMeterData(verifyMeterResponse);
        } else {
          MekNotification().showMessage(
            ctx,
            message: request['message'].toString(),
          );
        }
      } else {
        MekNotification().showMessage(
          ctx,
          message: "An error occurred, Please check your internet connection !!!",
        );
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: "An error occurred, Please try again later !!!",
      );
    }
  }

  void setSelectedCountry(CountryModel country) {
    selectedCountry = country;
    notifyListeners();
  }

  void setSelectedLoanCountry(CountryModel country) {
    selectedLoanCountry = country;
    notifyListeners();
  }

  void setSelectedBiller(PowerModel biller) {
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
        await getLoanCountry();
      }
    }
  }

  changeCallInitState(bool state) {
    shouldCallInit = state;
    notifyListeners();
  }
}

String generateRandomReference() {
  const int length = 18;
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()+{}~';
  final Random random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}
