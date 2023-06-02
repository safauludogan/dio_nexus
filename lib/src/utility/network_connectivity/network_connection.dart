import 'package:flutter/material.dart';

import 'internet_connection_manager.dart';

typedef CheckConnectionCallback = void Function();

class NetworkConnection {
  late IInternetConnectionManager _internetConnectionManager;
  CheckConnectionCallback? _checkConnectionCallback;
  BuildContext context;
  NetworkConnection({required this.context}) {
    _internetConnectionManager = InternetConnectionManager();
  }

  Future<void> checkConnection(
      CheckConnectionCallback checkConnectionCallback) async {
    _checkConnectionCallback = checkConnectionCallback;
    ConnectionResult connectionResult =
        await _internetConnectionManager.checkInternetConnectionOneTimes();
    if (connectionResult == ConnectionResult.off) {
      _showNoConnectionView(connectionResult);
    }
  }

  void _showNoConnectionView(ConnectionResult connectionResult) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      content: const Text('İnternet bağlantınız yok',
          style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        textColor: Colors.white,
        label: "Tekrar dene",
        onPressed: () => _checkConnectionCallback?.call(),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
