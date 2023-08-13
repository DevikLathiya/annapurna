import 'dart:developer';
import 'package:flutter/material.dart';

var currencySymbol = "₹";

void showSnackBar(
    {required BuildContext context,
    required String message,
    Color? backgroundColor,
    Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: backgroundColor ?? Colors.black87,
      content: Text(message),
    ),
  );
}

handleApiError(errorMessage, BuildContext context) {
  showSnackBar(
      backgroundColor: Colors.redAccent,
      message: errorMessage,
      context: context);
}

showWarning(message, BuildContext context) {
  showSnackBar(
    backgroundColor: Colors.blueAccent,
    message: message,
    context: context,
    duration: const Duration(seconds: 3),
  );
}

String findAge(String date){
  DateTime dob = DateTime.parse(date);
  Duration dur =  DateTime.now().difference(dob);
  String differenceInYears = (dur.inDays/365).floor().toString();
  return differenceInYears ;
}


showSuccessSnackbar(String message, BuildContext context) {
  showSnackBar(
      backgroundColor: Colors.green, message: message, context: context);
}

bool validatePassword(String password) {
  return RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~?]).{8,}$')
      .hasMatch(password);
}

bool validateEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool validatePAN(String value) {
  return RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(value);
}

bool validURL(String url) {
  return Uri.parse(url).isAbsolute;
}