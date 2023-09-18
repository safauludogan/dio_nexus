import 'dart:async';

import 'package:dio_nexus/src/constants/color_constants.dart';
import 'package:dio_nexus/src/network/nexus_language.dart';
import 'package:dio_nexus/src/utility/network_connectivity/internet_connection_manager.dart';
import 'package:flutter/material.dart';

/// The NetworkConnection class represents a connection to a network.
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

  NetworkConnection({
    required this.context,
    this.snackbarDuration,
    this.title,
    this.label,
    this.labelColor,
    this.backgroundColor,
  }) {
    _internetConnectionManager = InternetConnectionManager();
  }

  Future<bool> checkInternetConnection(
    void Function(bool timeOut) timeOut,
    void Function(bool retry) onRetry,
  ) async {
    final complater = Completer<bool>();

    final connectionResult =
        await _internetConnectionManager.checkInternetConnectionOneTimes();
    if (connectionResult == ConnectionResult.on) {
      complater.complete(true);
    } else if (connectionResult == ConnectionResult.off && context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      final snackBar = SnackBar(
        duration: snackbarDuration ?? Duration(seconds: _defaultSecond),
        content: title ??
            Text(
              NexusLanguage.getLangValue.networkConnectionNoInternetConnection,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
        onVisible: () {
          //? When there is no click on the "Retry" button, we will timeout the request within 5 seconds.
          //? When the Snackbar is visible, this timeout will be reset.
          if (_timer != null) _timer?.cancel();
          var start = snackbarDuration?.inSeconds ?? _defaultSecond;
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
        padding: const EdgeInsets.only(left: 12),
        backgroundColor:
            backgroundColor ?? ColorConstants.networkConnectionColorRed,
        action: SnackBarAction(
          textColor: labelColor ?? ColorConstants.networkConnectionColorWhite,
          label: label ?? NexusLanguage.getLangValue.networkConnectionTryAgain,
          onPressed: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            onRetry.call(true);
            final connectionResult = await _internetConnectionManager
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
