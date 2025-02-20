import 'package:connectivity_plus/connectivity_plus.dart';

/// The IInternetConnectionManager class is an abstract class for managing internet connections.
abstract class IInternetConnectionManager {
  /// The `checkInternetConnectionOneTimes()` method is a function declaration in the
  /// `IInternetConnectionManager` abstract class. It returns a `Future` that resolves to a
  /// `ConnectionResult` enum value. This method is responsible for checking the internet connection
  /// status once.
  Future<ConnectionResult> checkInternetConnectionOneTimes();
}

/// The InternetConnectionManager class is a concrete implementation of the IInternetConnectionManager interface.
class InternetConnectionManager extends IInternetConnectionManager {
  /// The constructor of the InternetConnectionManager.
  InternetConnectionManager() {
    _connectivity = Connectivity();
  }

  /// The connectivity instance.
  late final Connectivity _connectivity;

  @override

  /// The function to check the internet connection one times.
  Future<ConnectionResult> checkInternetConnectionOneTimes() async =>
      ConnectionResult.check(await _connectivity.checkConnectivity());
}

/// The enum ConnectionResult is a list of possible connection results.
enum ConnectionResult {
  /// The internet connection is on.
  on,

  /// The internet connection is off.
  off;

  /// The function checks the connectivity result and returns a connection result.
  static ConnectionResult check(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.contains(ConnectivityResult.bluetooth) ||
        connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.ethernet) ||
        connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.other) ||
        connectivityResults.contains(ConnectivityResult.vpn)) {
      return ConnectionResult.on;
    }
    return ConnectionResult.off;
  }
}
