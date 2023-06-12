import 'package:flutter/material.dart';

class NoInternetConnectionView extends StatelessWidget {
  const NoInternetConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('İnternet bağlantınz yok!'),
        SizedBox(width: 15),
        Icon(Icons.wifi_off_outlined),
      ],
    );
  }
}
