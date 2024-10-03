import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsableContants {
  static bool? populatedAlready;
}

class MekStorage {
  SharedPreferences? _preferences;

  init() async {
    print("Inside shared");
    _preferences = await SharedPreferences.getInstance();
  }

  Future<String?> getString(key) async {
    final SharedPreferences prefs = _preferences!;
    String? res = prefs.getString("$key");
    return res;
  }

  /// Adding a string value
  dynamic getJson(key) async {
    final SharedPreferences prefs = _preferences!;
    String jsonString = prefs.getString("$key")!;
    var res = jsonDecode(jsonString);
    return res;
  }

  /// Adding a string value
  Future<bool> putString(key, val) async {
    final SharedPreferences prefs = _preferences!;
    var res = prefs.setString("$key", val);
    return res;
  }

  /// Adding a bool value
  dynamic putBool(key, val) async {
    final SharedPreferences prefs = _preferences!;
    var res = prefs.setBool("$key", val);
    return res;
  }

  /// Adding a bool value
  dynamic getBool(key) async {
    final SharedPreferences prefs = _preferences!;
    var res = prefs.getBool("$key");
    return res;
  }

  /// Adding a list or object
  /// Use import 'dart:convert'; for jsonEncode
  dynamic putJson(key, val) async {
    final SharedPreferences prefs = _preferences!;
    var valString = jsonEncode(val);
    var res = prefs.setString("$key", valString);
    return res;
  }

  dynamic removeData(String key) async {
    await _preferences?.remove(key);
  }

  dynamic clear() async {
    await _preferences?.clear();
  }
}

class MekSecureStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

// Read value
  dynamic getSecuredKeyStoreData(String sKey) async {
    String? value = await storage.read(key: sKey);
    return value;
  }

// Read all values
  dynamic readAllStoreData() async {
    Map<String, String> allValues = await storage.readAll();
    return allValues;
  }

// Delete value
  dynamic deletKeyStoreData(String sKey) async {
    await storage.delete(key: sKey);
  }

// Delete all
  dynamic deleteAllStorageData() async {
    await storage.deleteAll();
  }

// Write value
  dynamic storeByKey(String sKey, dynamic valueToBeStored) async {
    await storage.write(key: sKey, value: valueToBeStored);
  }
}
