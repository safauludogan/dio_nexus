import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';

import '../../../product/components/no_internet_connection_view.dart';

class NetworkErrorResolver {
  NetworkExceptions error;
  NetworkErrorResolver(this.error);

  Widget errorWidget() {
    if (error == const NetworkExceptions.noInternetConnection()) {
      return const Center(child: NoInternetConnectionView());
    }
    return Center(child: Text(NetworkExceptions.getErrorMessage(error)));
  }
}
