import 'package:dio_nexus/src/constants/color_constants.dart';
import 'package:dio_nexus/src/constants/varible_constants.dart';
import 'package:dio_nexus/src/network/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TimeoutToast {
  final bool showException;
  final Color? backgroundColor;
  final Color? textColor;
  final int? timeForToast;
  final double? toastFontSize;
  final ToastGravity? gravity;
  final Toast? toastLength;
  TimeoutToast(
      {this.showException = false,
      this.backgroundColor,
      this.textColor,
      this.timeForToast,
      this.toastFontSize,
      this.gravity,
      this.toastLength});

  void show(NetworkExceptions exceptions) {
    if (!showException) return;
    String text;
    if (exceptions == const NetworkExceptions.receiveTimeout()) {
      text = NetworkExceptions.getErrorMessage(
          const NetworkExceptions.receiveTimeout());
    } else if (exceptions == const NetworkExceptions.requestTimeout()) {
      text = NetworkExceptions.getErrorMessage(
          const NetworkExceptions.requestTimeout());
    } else {
      return;
    }
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: text,
        toastLength: toastLength ?? Toast.LENGTH_LONG,
        gravity: gravity ?? ToastGravity.CENTER,
        timeInSecForIosWeb: timeForToast ?? VaribleConstants.timeForToast,
        backgroundColor: backgroundColor ?? ColorConstants.toastBackgroundColor,
        textColor: textColor ?? ColorConstants.toastTextColor,
        fontSize: toastFontSize ?? VaribleConstants.toastFontSize);
  }
}
