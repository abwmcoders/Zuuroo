import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../cache/orage_cred.dart';
import '../cache/storage.dart';
import '../locator.dart';

class BaseServices {
  static final baseUrl = "${dotenv.env["API_URL"]}";
  final _mekStorage = getIt<MekStorage>();

  //getUserToken from store
  Future getUserToken() async {
    String? token =
        await MekSecureStorage().getSecuredKeyStoreData(StorageKeys.token);
    return token ?? "";
  }

  //get request
  Future tokenizedGetRequest({
    String? token,
    dynamic data,
    required String url,
    Map<String, String>? queryParams,
  }) async {
    final String url0 = baseUrl;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(
          Uri.parse(url0 + url).replace(queryParameters: queryParams),
          headers: headers);
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

  //untokenized get  request
  Future getRequest({required String url, bool decodeJson = false}) async {
    final String _url = baseUrl + url;
    try {
      final _response = await http.get(Uri.parse(_url), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      });
      final _result =
          decodeJson == true ? _response : jsonDecode(_response.body);

      return _result;
    } catch (e) {
      debugPrint("error cateched $e");
      return null;
    }
  }

  Future getListRequest({required String url}) async {
    final String _url = baseUrl + url;
    try {
      final _response = await http.get(Uri.parse(_url));
      Map<String, dynamic>? map = json.decode(_response.body);

      return map;
    } catch (e) {
      debugPrint("error cateched $e");
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
        return result;
      }
    } on SocketException {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future tokenizedPutRequest(
      {String? token, dynamic data, required String url}) async {
    final String url0 = url;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http
          .put(Uri.parse(baseUrl + url0),
              headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: 30));

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return result;
      }
      if (response.statusCode == 422) {
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
      print("Socket issues");
      return null;
    } catch (e) {
      print("catcht issues -----> ${e.toString()}");
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
