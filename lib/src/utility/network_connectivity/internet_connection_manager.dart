import 'package:connectivity_plus/connectivity_plus.dart';

/// The IInternetConnectionManager class is an abstract class for managing internet connections.
abstract class IInternetConnectionManager {
  /// The `checkInternetConnectionOneTimes()` method is a function declaration in the
  /// `IInternetConnectionManager` abstract class. It returns a `Future` that resolves to a
  /// `ConnectionResult` enum value. This method is responsible for checking the internet connection
  /// status once.
  Future<ConnectionResult> checkInternetConnectionOneTimes();
}

class InternetConnectionManager extends IInternetConnectionManager {
  late Connectivity _connectivity;
  InternetConnectionManager() {
    _connectivity = Connectivity();
  }
  @override
  Future<ConnectionResult> checkInternetConnectionOneTimes() async {
    final result = await _connectivity.checkConnectivity();
    return ConnectionResult.check(result);
  }
}

/// In the code snippet provided, `off;` is defining one of the enum values for the `ConnectionResult`
/// enum. The `off` value represents the case when the internet connection is not available.
enum ConnectionResult {
  on,
  off;

  /// The function checks the connectivity result and returns a connection result.
  /// 
  /// Args:
  ///   connectivityResult (ConnectivityResult): The parameter "connectivityResult" is of type
  /// "ConnectivityResult".
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
