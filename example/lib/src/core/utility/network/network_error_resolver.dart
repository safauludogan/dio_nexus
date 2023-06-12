import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';

import '../../../product/components/no_internet_connection_view.dart';

class NetworkErrorResolver {
  NetworkExceptions error;
  NetworkErrorResolver(this.error);
  Function? onReceiveData;

  Widget errorWidget({required Function() receiveData}) {
    if (error == const NetworkExceptions.noInternetConnection()) {
      return const Center(child: NoInternetConnectionView());
    } else if (error == const NetworkExceptions.receiveTimeout()) {
      return Column(
        children: [
          const Text('Sunucudan yanıt alınamadı'),
          OutlinedButton(
              onPressed: () => receiveData.call(),
              child: const Text('Tekrar dene'))
        ],
      );
    }
    return Center(child: Text(NetworkExceptions.getErrorMessage(error)));
  }
}
