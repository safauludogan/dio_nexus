import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';
import 'package:network_manager_test/src/home/model/register.dart';

import '../model/single_user_model.dart';
import '../model/users_model.dart';
import '../view/home_view.dart';

abstract class HomeViewmodel extends State<HomeView> {
  late IDioNexusManager dioNexusManager;
  @override
  void initState() {
    super.initState();
    dioNexusManager = DioNexusManager(
        printLogsDebugMode: false,
        options: BaseOptions(
          baseUrl: "https://reqres.in/",
          headers: {'Content-type': 'application/json'},
        ),
        networkConnection: NetworkConnection(
          context: context,
          snackbarDuration: const Duration(seconds: 5),
        ));
  }

  bool isLoading = false;

  Future<IResponseModel<Users?>?> getUserList() async {
    IResponseModel<Users?>? response;
    try {
      changeLoading();
      response = await dioNexusManager.sendRequest<Users, Users>(
        "api/users",
        requestType: RequestType.GET,
        responseModel: Users(),
      );
      print("Register : ${response?.toString()}");
    } finally {
      changeLoading();
    }
    return response;
  }

  Future<IResponseModel<SingleUser?>?> getUser() async {
    changeLoading();
    IResponseModel<SingleUser?>? response =
        await dioNexusManager.sendRequest<SingleUser, SingleUser>(
      "api/users/2",
      requestType: RequestType.GET,
      responseModel: SingleUser(),
    );
    print("Register : ${response?.toString()}");
    changeLoading();
    return response;
  }

  Future<IResponseModel<Users?>?> getUsersWithDelay() async {
    changeLoading();
    IResponseModel<Users?>? response =
        await dioNexusManager.sendRequest<Users, Users>(
      "api/users?delay=5",
      requestType: RequestType.GET,
      responseModel: Users(),
    );
    print("Register : ${response?.toString()}");
    changeLoading();
    return response;
  }

  Future<IResponseModel<Register?>?> registerUnsuccessful() async {
    changeLoading();
    IResponseModel<Register?>? response =
        await dioNexusManager.sendRequest<Register, Register>("api/register",
            requestType: RequestType.POST,
            responseModel: Register(),
            data: Register(email: 'sydney@fife'));
    print("Register : ${response?.toString()}");

    changeLoading();
    return response;
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
