import 'package:dio_nexus/src/constants/index.dart';
import 'package:dio_nexus/src/network/index.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// The TimeoutToast class is used to display a toast message with a timeout.
class TimeoutToast {
  /// The constructor of the TimeoutToast class.
  TimeoutToast({
    this.showException = false,
    this.backgroundColor,
    this.textColor,
    this.timeForToast,
    this.toastFontSize,
    this.gravity,
    this.toastLength,
  });

  /// Whether to show the exception.
  final bool showException;

  /// The background color of the toast.
  final Color? backgroundColor;

  /// The text color of the toast.
  final Color? textColor;

  /// The time for the toast.
  final int? timeForToast;

  /// The font size of the toast.
  final double? toastFontSize;

  /// The gravity of the toast.
  final ToastGravity? gravity;

  /// The length of the toast.
  final Toast? toastLength;

  /// The function to show the toast.
  void show(NetworkExceptions exceptions) {
    if (!showException) return;
    String text;
    if (exceptions == const NetworkExceptions.receiveTimeout()) {
      text = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.receiveTimeout(),
      );
    } else if (exceptions == const NetworkExceptions.requestTimeout()) {
      text = NetworkExceptions.getErrorMessage(
        const NetworkExceptions.requestTimeout(),
      );
    } else {
      return;
    }
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength ?? Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.CENTER,
      timeInSecForIosWeb: timeForToast ?? VariableConstants.toastDuration,
      backgroundColor: backgroundColor ?? ColorConstants.toastBackgroundColor,
      textColor: textColor ?? ColorConstants.toastTextColor,
      fontSize: toastFontSize ?? VariableConstants.toastFontSize,
    );
  }
}
