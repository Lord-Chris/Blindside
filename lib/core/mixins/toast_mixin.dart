import 'package:flutter/material.dart';

class ToastMixin {
  static final scaffoldkey = GlobalKey<ScaffoldMessengerState>();

  void showSuccessToast(String message) {
    scaffoldkey.currentState?.showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
    ));
  }

  void showFailureToast(String message) {
    scaffoldkey.currentState?.showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(message),
    ));
  }
}
