import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zuuro/app/cache/storage.dart';
import 'package:zuuro/presentation/view/home/model/home_model.dart';

import '../../../../app/app_constants.dart';
import '../../../../app/base/base_view_model/base_vm.dart';
import '../../../../app/services/api_rep/user_services.dart';

class HomeProvider extends BaseViewModel {
  BuildContext? context;
  dynamic homeData;
  HomeProvider({this.context, this.shouldCallInit = true, this.homeData});
  bool shouldCallInit = false;
  bool showBalance = false;

  void toggleBalance() {
    showBalance = !showBalance; // Toggle the value
    notifyListeners();
  }

  @override
  FutureOr<void> initState() async {
    if (homeData == null || AppConstants.homeModel == null) {
      if (shouldCallInit) {
        await getUserRecords();
        changeCallInitState(false);
      }
    }
  }

  changeCallInitState(bool state) {
    shouldCallInit = state;
    notifyListeners();
  }

  //get user records
  final bool getUserRecordsInit = false;
  getUserRecords() async {
    homeData = await UserApiServices().getUserRecords();
    if (homeData != null) {
      final _userResults = HomeModel.fromJson(homeData);
      AppConstants.homeModel = _userResults;
      notifyListeners();
    }
  }

  @override
  FutureOr<void> disposeState() {}
}
