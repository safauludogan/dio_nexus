import 'package:dio/dio.dart';
import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';
import 'package:network_manager_test/src/home/model/users_model.dart';

import '../model/single_user_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late IDioNexusManager dioNexusManager;
  @override
  void initState() {
    super.initState();
    dioNexusManager = DioNexusManager(
        options: BaseOptions(baseUrl: "https://reqres.in/"),
        networkConnection: NetworkConnection(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            IResponseModel<Users?> response =
                await dioNexusManager.sendRequest<Users, Users>(
              "api/users",
              requestType: RequestType.GET,
              responseModel: Users(),
            );
            print(response.model);
            print(response.statusCode);
          },
          child: const Text('Get User List'),
        ),
        ElevatedButton(
          onPressed: () async {
            IResponseModel<SingleUser?> response =
                await dioNexusManager.sendRequest<SingleUser, SingleUser>(
              "api/users/2",
              requestType: RequestType.GET,
              responseModel: SingleUser(),
            );
            print(response.model.toString());
          },
          child: const Text('Get Single User'),
        )
      ],
    )));
  }
}
