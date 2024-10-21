import 'dart:io';

import '../../../../../app/api_constants.dart';
import '../../../../../app/locator.dart';
import '../../../../../app/services/base_services.dart';
import '../model/kyc_model.dart';

class KycRepository extends BaseServices{

  Future kyc({required KycModel verify}) async {
    var rm;
    var body = {
      "firstname": verify.first,
      "middlename": verify.middle,
      "lastname": verify.last,
      "bvn": verify.bvn,
      "dd": verify.dd,
      "mm": verify.mm,
      "yy": verify.yyyy,
    };
    try {
      await getUserToken().then((token) {
        rm = tokenizedPostRequest(token: token, url: ApiConstants.kyc, data: body);
      });
      return rm;
    } on SocketException {
      return "Socket exception occurred";
    } catch (e) {
      return e;
    }
  }
}
