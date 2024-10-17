import 'dart:developer';

import 'package:zuuro/app/api_constants.dart';
import 'package:zuuro/app/app_constants.dart';

import '../base_services.dart';

class UserApiServices extends BaseServices {
  Future getUserRecords() async {
    var rm;
    String token = await getUserToken();
    try {
      await getUserToken().then((value) {
        rm = tokenizedGetRequest(token: value, url: ApiConstants.home);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future getCountryList() async {
    var rm;
    String token = await getUserToken();
    try {
      await getUserToken().then(
        (value) {
          rm = tokenizedGetRequest(token: value, url: ApiConstants.country);
        },
      );
      return rm;
    } catch (e) {
      return null;
    }
  }
  Future getCountry() async {
    var rm;
    try {
      rm = await getRequest(url: ApiConstants.ct);
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future getCableList() async {
    var rm;
    String token = await getUserToken();
    try {
      await getUserToken().then(
        (value) {
          rm = tokenizedGetRequest(token: value, url: ApiConstants.cable);
        },
      );
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future getBillerList() async {
    var rm;
    String token = await getUserToken();
    try {
      await getUserToken().then(
        (value) {
          rm = tokenizedGetRequest(token: value, url: ApiConstants.biller);
        },
      );
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future getHistories() async {
    var rm;
    String token = await getUserToken();
    try {
      await getUserToken().then(
        (value) {
          rm = tokenizedGetRequest(token: value, url: ApiConstants.history);
        },
      );
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future getOperatorList(String countryCode) async {
    var rm;
    String token = await getUserToken();
    try {
      await getUserToken().then((value) {
        rm = tokenizedGetRequest(
            token: value, url: "${ApiConstants.operator}" + "$countryCode");
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future getCablePlan(String code) async {
    var rm;
    String token = await getUserToken();
    try {
      await getUserToken().then((value) {
        rm = tokenizedGetRequest(
            token: value, url: "${ApiConstants.cablePlan}$code");
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future purchaseAirtime(dynamic data) async {
    var rm;
    try {
      await getUserToken().then((token) {
        rm = tokenizedPostRequest(token: token, url: ApiConstants.airtime, data: data);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future purchaseCable(dynamic data) async {
    var rm;
    try {
      await getUserToken().then((token) {
        rm = tokenizedPostRequest(token: token, url: ApiConstants.cablePayment, data: data);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future changePassword(dynamic data) async {
    var rm;
    try {
      await getUserToken().then((token) {
        rm = tokenizedPutRequest(token: token, url: ApiConstants.changePassword, data: data);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future changePin(dynamic data) async {
    var rm;
    try {
      await getUserToken().then((token) {
        rm = tokenizedPutRequest(token: token, url: ApiConstants.changePin, data: data);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future purchaseBill(dynamic data) async {
    var rm;
    try {
      await getUserToken().then((token) {
        rm = tokenizedPostRequest(token: token, url: ApiConstants.bill, data: data);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future verifyPin(dynamic data) async {
    var rm;
    try {
      await getUserToken().then((token) {
        rm = tokenizedPostRequest(token: token, url: ApiConstants.pin, data: data);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future verifyMeterNumber(dynamic data) async {
    var rm;
    try {
      await getUserToken().then((token) {
        rm = tokenizedPostRequest(token: token, url: ApiConstants.verifyMeter, data: data);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }

  Future verifyIucNumber(dynamic data) async {
    var rm;
    try {
      await getUserToken().then((token) {
        rm = tokenizedPostRequest(token: token, url: ApiConstants.verifyIuc, data: data);
      });
      return rm;
    } catch (e) {
      return null;
    }
  }
}
