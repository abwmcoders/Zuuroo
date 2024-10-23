import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_view_model/base_vm.dart';

class DataProvider extends BaseViewModel {
  BuildContext? context;

  DataProvider({
    this.context,
  });
  //! --------- ----------
  @override
  FutureOr<void> disposeState() {}

  @override
  FutureOr<void> initState() {}
}
