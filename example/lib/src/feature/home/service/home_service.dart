import 'package:dio_nexus/dio_nexus.dart';
import 'package:example/src/feature/home/model/register.dart';
import 'package:example/src/feature/home/model/single_user_model.dart';
import 'package:example/src/feature/home/model/users_model.dart';
import 'IHomeService.dart';

class HomeService extends IHomeService {
  HomeService(super.nexusManager);

  @override
  Future<IResponseModel<SingleUser?>?> getUser(int page) async {
    IResponseModel<SingleUser?>? response =
        await nexusManager.sendRequest<SingleUser, SingleUser>(
      "api/users/$page",
      requestType: RequestType.GET,
      responseModel: SingleUser(),
    );
    return response;
  }

  @override
  Future<IResponseModel<Users?>?> getUsers() async {
    IResponseModel<Users?>? response =
        await nexusManager.sendRequest<Users, Users>(
      "api/users",
      requestType: RequestType.GET,
      responseModel: Users(),
    );
    return response;
  }

  @override
  Future<IResponseModel<Users?>?> getUsersWithDelay(int delayTime) async {
    IResponseModel<Users?>? response =
        await nexusManager.sendRequest<Users, Users>(
      "api/users?delay=$delayTime",
      requestType: RequestType.GET,
      responseModel: Users(),
    );
    return response;
  }

  @override
  Future<IResponseModel<Register?>?> register(Register register) async {
    IResponseModel<Register?>? response =
        await nexusManager.sendRequest<Register, Register>("api/register",
            requestType: RequestType.POST,
            responseModel: Register(),
            data: register);
    return response;
  }
}
