import 'dart:async';

import 'package:dio_nexus/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../constants/string_constants.dart';
import 'internet_connection_manager.dart';

class NetworkConnection {
  late IInternetConnectionManager _internetConnectionManager;

  ///Sets the duration of the retry widget that appears when you are not connected to the internet. After this time, the widget disappears from the screen. Default value 5 seconds
  Duration? snackbarDuration;
  Text? title;
  String? label;
  Color? labelColor;
  Color? backgroundColor;
  BuildContext context;
  Timer? _timer;
  final int _defaultSecond = 5;
  NetworkConnection(
      {required this.context,
      this.snackbarDuration,
      this.title,
      this.label,
      this.labelColor,
      this.backgroundColor}) {
    _internetConnectionManager = InternetConnectionManager();
  }

  Future<bool> checkInternetConnection(
      void Function(bool timeOut) timeOut, Function(bool retry) onRetry) async {
    final complater = Completer<bool>();

    var connectionResult =
        await _internetConnectionManager.checkInternetConnectionOneTimes();
    if (connectionResult == ConnectionResult.on) {
      complater.complete(true);
    } else if (connectionResult == ConnectionResult.off && context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      final snackBar = SnackBar(
        duration: snackbarDuration ?? Duration(seconds: _defaultSecond),
        content: title ??
            const Text(StringConstants.networkConnectionNoInternetConnection,
                style: TextStyle(color: Colors.white)),
        onVisible: () {
          //? When there is no click on the "Retry" button, we will timeout the request within 5 seconds.
          //? When the Snackbar is visible, this timeout will be reset.
          if (_timer != null) _timer?.cancel();
          int start = snackbarDuration?.inSeconds ?? _defaultSecond;
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (start == 0) {
              timeOut.call(true);
              if (!complater.isCompleted) complater.complete(false);
              timer.cancel();
              _timer?.cancel();
            } else {
              start--;
            }
          });
        },
        backgroundColor:
            backgroundColor ?? ColorConstants.networkConnectionColorRed,
        action: SnackBarAction(
          textColor: labelColor ?? ColorConstants.networkConnectionColorWhite,
          label: label ?? StringConstants.networkConnectionTryAgain,
          onPressed: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            onRetry.call(true);
            var connectionResult = await _internetConnectionManager
                .checkInternetConnectionOneTimes();
            if (connectionResult == ConnectionResult.on) {
              complater.complete(true);
              _timer?.cancel();
            } else {
              complater.complete(false);
            }
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return complater.future;
  }
}
