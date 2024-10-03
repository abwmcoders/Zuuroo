import 'dart:io';

import 'package:zuuro/app/api_constants.dart';
import 'package:zuuro/presentation/view/auth/register/model/reg_model.dart';

import '../../../../../app/locator.dart';
import '../../../../../app/services/base_services.dart';

class RegisterRepository {
  final baseServices = getIt<BaseServices>();

  Future register(RegModel user) async {
    var body = {
      "name": user.name,
      "email": user.email,
      "password": user.password,
      "password_confirmation": user.password,
      "telephone": int.parse(user.telephone!),
      "username": user.username,
      "dob": user.dob,
      "gender": user.gender,
      "address": user.address,
      "country": user.country,
      "create_pin": user.pin,
    };
    try {
      var response =
          baseServices.postRequest(url: ApiConstants.registerUrl, data: body);
      return response;
    } on SocketException {
      return "Socket exception occurred";
    } catch (e) {
      return e;
    }
  }
}
