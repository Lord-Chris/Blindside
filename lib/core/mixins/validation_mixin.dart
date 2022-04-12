import 'package:stacked_services/stacked_services.dart';

mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value == null) return 'Please enter an email address';
    value.isEmail;

    bool emailValid = value.isEmail;
    return !emailValid ? 'Enter a Valid Email Address' : null;
  }

  String? nonEmptyValidation(String? val) {
    if (val == null || val.isEmpty) return "Field must not be empty";
    return null;
  }

  String? passwordValidation(String? val) {
    if (val == null || val.isEmpty) return "Field must not be empty";
    if (val.length < 6) return "Password must be more than 7 characters";
    return null;
  }

  String? confirmPasswordValidation(String? val, String ref) {
    if (val != ref) return "Passwords do not match";
    return null;
  }
}
