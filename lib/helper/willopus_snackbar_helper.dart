import 'package:flutter/material.dart';

/// Show quick popup in-app notifications.
class WillOpusSnackbarHelper {
  static void showSnackBar(BuildContext context, String txt) {
    var snackBar = SnackBar(
      content: Text(txt),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
