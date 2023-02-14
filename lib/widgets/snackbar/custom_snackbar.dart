import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class CustomSnackbar {
  static buildSnackbar(
      {required String title,
      required String message,
      int durationMilliseconds = 5000,
      required void Function() action,
      bool isError = false}) {
    return SnackBar(
      content: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '$title\n',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isError ? Colors.amber[900] : Colors.lightGreen[700],
            ),
          ),
          TextSpan(
              text: message,
              style: const TextStyle(color: Colors.grey, fontSize: 18)),
        ]),
      ),
      duration: Duration(milliseconds: durationMilliseconds),
      action: SnackBarAction(
        label: 'OK',
        onPressed: action,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 120, left: 30.0, right: 30.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
