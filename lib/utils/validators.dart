import '../core/app_strings.dart';

class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value!)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? studentId(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    final studentIdRegex = RegExp(r'^[A-Za-z0-9]{4,10}$');
    if (!studentIdRegex.hasMatch(value!)) {
      return AppStrings.invalidStudentId;
    }
    return null;
  }

  static String? password(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (value!.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (value != password) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }
}
