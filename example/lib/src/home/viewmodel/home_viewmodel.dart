import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';

import '../model/single_user_model.dart';
import '../model/users_model.dart';
import '../view/home_view.dart';

abstract class HomeViewmodel extends State<HomeView> {
  late IDioNexusManager dioNexusManager;
  @override
  void initState() {
    super.initState();
    dioNexusManager = DioNexusManager(
        options: BaseOptions(baseUrl: "https://reqres.in/"),
        networkConnection: NetworkConnection(
          context: context,
          snackbarDuration: const Duration(seconds: 5),
        ));
  }

  bool isLoading = false;

  Future<IResponseModel<Users?>?> getUserList() async {
    changeLoading();
    IResponseModel<Users?>? response =
        await dioNexusManager.sendRequest<Users, Users>(
      "api/users",
      requestType: RequestType.GET,
      responseModel: Users(),
    );
    print("Result Users : ${response?.model}");
    changeLoading();
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
    print("Result Single User : ${response?.model}");
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
    print("Result User with Delay : ${response?.model}");
    print("Dio error type : ${response?.dioErrorType}");
    changeLoading();
    return response;
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
