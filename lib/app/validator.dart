// ignore_for_file: unnecessary_null_comparison

import '../presentation/resources/resources.dart';

class FieldValidator {
  String? validateEmail(String value, {String emptyMessage = ""}) {
    if (value != null) {
      if (value.isEmpty) {
        return AppStrings().emptyEmailField(fieldType: emptyMessage);
      }
      // Regex for email validation
      final regExp = RegExp(AppStrings().emailRegex);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return AppStrings().invalidEmailField;
    } else {
      return null;
    }
  }

  String? validate(String value, {String? validatorText}) {
    if (value != null) {
      if (value.isEmpty) {
        return validatorText ?? AppStrings().emptyTextField;
      }
    } else {
      return null;
    }

    return null;
  }

  String? confirmPassword(String password, String comfirm,{String? validatorText}) {
    if (password != null) {
      if (password.isEmpty) {
        return validatorText ?? AppStrings().emptyTextField;
      }
    } else if(password != comfirm) {
      return validatorText ?? AppStrings().passwordErrorTextField;
    }
    else {
      return null;
    }

    return null;
  }
}
