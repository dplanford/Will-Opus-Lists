import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSnackBar(BuildContext context, String txt) {
    var snackBar = SnackBar(
      content: Text(txt),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
