import 'dart:async';

import 'package:flutter/material.dart';

import 'internet_connection_manager.dart';

typedef CheckConnectionCallback = Future Function(Future<bool> isRetry);

class NetworkConnection {
  late IInternetConnectionManager _internetConnectionManager;
  BuildContext context;
  NetworkConnection({required this.context}) {
    _internetConnectionManager = InternetConnectionManager();
  }

  Future<bool> checkConnection() async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final complater = Completer<bool>();
    final snackBar = SnackBar(
      duration: const Duration(seconds: 10),
      content: const Text('İnternet bağlantınız yok',
          style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        textColor: Colors.white,
        label: "Tekrar dene",
        onPressed: () async {
          var connectionResult = await _internetConnectionManager
              .checkInternetConnectionOneTimes();
          connectionResult == ConnectionResult.on
              ? complater.complete(true)
              : complater.complete(false);
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return complater.future;
  }
}
