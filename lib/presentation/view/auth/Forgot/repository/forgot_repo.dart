import 'dart:io';

import '../../../../../app/api_constants.dart';
import '../../../../../app/locator.dart';
import '../../../../../app/services/base_services.dart';
import '../model/forget_model.dart';

class ForgotPasswordRepository {
  final baseServices = getIt<BaseServices>();

  Future resetPassword(ForgetPasswordModel data) async {
    var body = {
      "email": data.email,
      "otp": data.email,
      "password": data.password,
      "password_confirmation": data.password,
    };
    try {
      var response =
          baseServices.postRequest(url: ApiConstants.resetPassword, data: body);
      return response;
    } on SocketException {
      return "Socket exception occurred";
    } catch (e) {
      return e;
    }
  }

  Future requestReset(dynamic data) async {
    try {
      var response =
          baseServices.postRequest(url: ApiConstants.resetPassword, data: data);
      return response;
    } on SocketException {
      return "Socket exception occurred";
    } catch (e) {
      return e;
    }
  }
}
