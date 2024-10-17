import 'dart:io';

import '../../../../../app/api_constants.dart';
import '../../../../../app/locator.dart';
import '../../../../../app/services/base_services.dart';

class VerifyRepository {
  final baseServices = getIt<BaseServices>();

  Future verifyEmail({String? email, String? otp}) async {
    var body = {
      "email": email,
      "otp": otp,
    };
    try {
      print("Body for vrificatio  ---> $body");
      var response =
          baseServices.postRequest(url: ApiConstants.verify, data: body);
      return response;
    } on SocketException {
      return "Socket exception occurred";
    } catch (e) {
      return e;
    }
  }
}
