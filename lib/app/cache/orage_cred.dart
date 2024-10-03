import 'package:zuuro/app/cache/storage.dart';
import 'package:zuuro/app/locator.dart';

class StorageKeys {
  static const onBoardingStorageKey = "session";
  static const emailKey = 'email';
  static const passWordKey = 'password';
  static const token = 'token';
}

class StorageCredentials {
  final _mekStorage = getIt<MekStorage>();

  Future<String> get onBoardingCredentailStatus async {
    String? checkingOnBoardingString =
        await _mekStorage.getString(StorageKeys.onBoardingStorageKey);
    return checkingOnBoardingString ?? 'NO SESSION';
  }
}
