import 'package:connectivity_plus/connectivity_plus.dart';

abstract class IInternetConnectionManager {
  Future<ConnectionResult> checkInternetConnectionOneTimes();
}

class InternetConnectionManager extends IInternetConnectionManager {
  late Connectivity _connectivity;
  InternetConnectionManager() {
    _connectivity = Connectivity();
  }
  @override
  Future<ConnectionResult> checkInternetConnectionOneTimes() async {
    var result = await _connectivity.checkConnectivity();
    return ConnectionResult.check(result);
  }
}

enum ConnectionResult {
  on,
  off;

  static ConnectionResult check(ConnectivityResult connectivityResult) {
    switch (connectivityResult) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.other:
      case ConnectivityResult.vpn:
        return ConnectionResult.on;
      case ConnectivityResult.none:
        return ConnectionResult.off;
    }
  }
}
