import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool _isDisposed = false;
  bool _isInitializeDone = false;
  bool isLoading = false;

  bool get isDisposed => _isDisposed;
  bool get isInitialized => _isInitializeDone;

  FutureOr<void> _initState;

  FutureOr<void> initState();
  FutureOr<void> disposeState();
  dismissKeyboard(context) => dismissKeyboardFocus;

  BaseViewModel() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      log("Init called vm .............");
      init();
    });
  }

   //! obscure text
  bool _obscureText = true;
  bool get obscureTextGetter => _obscureText;
  void obscure() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void init() async {
    log("Init call again ................");
    _initState = initState();
    await _initState;
    _isInitializeDone = true;
    initState();
  }

  changeLoaderStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  void dismissKeyboardFocus() {
    FocusManager.instance.primaryFocus!.unfocus();
  }


  @override
  void dispose() {
    _isDisposed = true;
    disposeState();
    super.dispose();
  }
}
