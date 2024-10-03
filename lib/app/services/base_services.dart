import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../cache/storage.dart';
import '../locator.dart';

class BaseServices {
  static final baseUrl = "${dotenv.env["API_URL"]}";
  final _mekStorage = getIt<MekStorage>();

  //getUserToken from store
  Future getUserRecords() async {
    final token = await _mekStorage.getString("mekUserToken");
    return token;
  }

  //get request
  Future tokenizedGetRequest(
      {String? token, dynamic data, required String url}) async {
    final String url0 = baseUrl;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(Uri.parse(url0 + url), headers: headers);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return result;
      }
      if (response.statusCode == 422) {
        return result;
      } else {
        return null;
      }
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  //make post request
  Future tokenizedPostRequest(
      {String? token, dynamic data, required String url}) async {
    final String url0 = url;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http
          .post(Uri.parse(baseUrl + url0),
              headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 30));

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return result;
      }
      if (response.statusCode == 422) {
        return result;
      } else {
        return null;
      }
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future postRequest({required String url, dynamic data}) async {
    final String url0 = baseUrl;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await http
          .post(Uri.parse(url0 + url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 20));
      final result = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return result;
      } else if (response.statusCode == 422) {
        return result;
      } else {
        return result;
      }
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future putRequest({required String url, dynamic data}) async {
    final String url0 = baseUrl;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final response = await http
          .put(
            Uri.parse(url0 + url),
            headers: headers,
            body: jsonEncode(data),
          )
          .timeout(
            const Duration(seconds: 20),
          );
      final result = jsonDecode(response.body);
      print("request status code ====> ${response.statusCode}");
      if (response.statusCode == 201 || response.statusCode == 200) {
        return result;
      }
      if (response.statusCode == 422) {
        return result;
      } else {
        return null;
      }
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
