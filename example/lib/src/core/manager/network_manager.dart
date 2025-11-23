import 'package:dio_nexus/dio_nexus.dart';
import 'package:example/src/core/manager/interceptors/network_interceptor.dart';
import 'package:flutter/material.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._init();
  static NetworkManager get instance => _instance;
  NetworkManager._init();

  void init(BuildContext context) async {
    networkManager = DioNexusManager(
        printLogsDebugMode: false,
        interceptor: MyInterceptor(),
        options: BaseOptions(
            baseUrl: "https://reqres.in/",
            headers: {
              'Content-type': 'application/json',
              'x-api-key': 'reqres-free-v1',
            },
            receiveTimeout: const Duration(seconds: 15),
            connectTimeout: const Duration(seconds: 15)),
        locale: const Locale('tr'),
        networkConnection: NetworkConnection(
          context: context,
          snackbarDuration: const Duration(seconds: 3),
        ),
        timeoutToast: TimeoutToast(showException: true));
  }

  late IDioNexusManager networkManager;
}
