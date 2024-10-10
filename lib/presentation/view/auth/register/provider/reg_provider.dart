// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zuuro/presentation/view/auth/register/model/reg_model.dart';
import 'package:zuuro/presentation/view/auth/register/repository/reg_repo.dart';
import 'package:zuuro/presentation/view/vtu/model/country_model.dart';

import '../../../../../app/animation/navigator.dart';
import '../../../../../app/base/base_view_model/base_vm.dart';
import '../../../../../app/cache/orage_cred.dart';
import '../../../../../app/cache/storage.dart';
import '../../../../../app/functions.dart';
import '../../../../../app/services/api_rep/user_services.dart';
import '../../../../resources/resources.dart';

class RegisterProvider extends BaseViewModel {
  BuildContext? context;
  final MekStorage? mekStorage;
  final String? fromState;
  RegisterProvider({this.context, this.mekStorage, this.fromState});

  PageController? pageController;
  int pageIndex = 0;
  String? pin;
  CountryModel? selectedCountry;

  setPin(String text) {
    pin = text;
    notifyListeners();
  }

  setCountry(CountryModel country) {
    selectedCountry = country;
    notifyListeners();
  }

  updatePageIndex(String from) {
    if (from == "info") {
      pageIndex = 1;
      notifyListeners();
    } else if (from == "password") {
      pageIndex = 2;
      notifyListeners();
    } else if (from == "pin") {
      pageIndex = 3;
      notifyListeners();
    }
    notifyListeners();
  }

  //! form variables
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController telController = TextEditingController(text: "");
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController dobController = TextEditingController(text: "");
  TextEditingController genderController = TextEditingController(text: "");
  TextEditingController countryController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  void setState({String? textFieldVal, required String value}) {
    textFieldVal = value;
    notifyListeners();
    if (kDebugMode) {
      print(textFieldVal);
    }
  }

  setIndex({required int result, required int value}) {
    value = result;
    notifyListeners();
  }

  void registerUser({required BuildContext ctx}) async {
    dismissKeyboard(ctx);
    changeLoaderStatus(true);
    RegModel user = RegModel(
      name: nameController.text.trim().toString(),
      username: usernameController.text.trim().toString(),
      email: emailController.text.trim().toString(),
      password: passwordController.text.trim().toString(),
      telephone: telController.text.trim().toString(),
      dob: dobController.text.trim().toString(),
      gender: genderController.text.trim().toString(),
      address: addressController.text.trim().toString(),
      country: countryController.text.trim().toString(),
      pin: pin,
    );
    try {
      var request = await RegisterRepository().register(user);
      changeLoaderStatus(false);
      if (kDebugMode) {
        print(request.toString());
      }
      if (request != null) {
        if (request['status'] == true) {
          mekStorage!.putString(
            StorageKeys.onBoardingStorageKey,
            "reg",
          );
          NavigateClass().pushNamed(
            context: ctx,
            routName: Routes.loginRoute,
          );
          nameController.clear();
          emailController.clear();
          usernameController.clear();
          passwordController.clear();
          dobController.clear();
          genderController.clear();
          addressController.clear();
          telController.clear();
          countryController.clear();
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

  
  Future<List<CountryModel>?> getCountryList({
    required BuildContext ctx,
  }) async {
    try {
      var request = await UserApiServices().getCountry();
      if (request != null) {
        if (request["success"] == true) {
          List<CountryModel> _countryResult = [];
          for (dynamic country in request['data']) {
            final countryModel = CountryModel.fromJson(country);
            bool exists = _countryResult.any((existingCountry) =>
                existingCountry.countryCode == countryModel.countryCode);

            if (!exists) {
              _countryResult.add(countryModel);
              notifyListeners();
            }
          }
          return _countryResult;
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


  @override
  FutureOr<void> disposeState() {
    pageController!.dispose();
  }

  @override
  FutureOr<void> initState() {
    pageController = PageController(
        initialPage: fromState == "info"
            ? 1
            : fromState == "password"
                ? 2
                : fromState == "pin"
                    ? 3
                    : fromState == "register"
                        ? 0
                        : 0);
    updatePageIndex(fromState!);
  }
}
