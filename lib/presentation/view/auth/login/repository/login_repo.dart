import 'dart:io';

import 'package:zuuro/app/api_constants.dart';

import '../../../../../app/locator.dart';
import '../../../../../app/services/base_services.dart';

class LoginRepository {
  final baseServices = getIt<BaseServices>();

  Future loginUser({String? email, String? password}) async {
    var body = {
      "email": email,
      "password": password,
    };
    try {
      var response = baseServices.postRequest(url: ApiConstants.loginUrl, data: body);
      return response;
    } on SocketException {
      return "Socket exception occurred";
    } catch (e) {
      return e;
    }
  }
  
}
