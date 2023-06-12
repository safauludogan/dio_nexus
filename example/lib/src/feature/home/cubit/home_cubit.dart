import 'package:dio_nexus/dio_nexus.dart';
import '../model/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<ResultState<Users>> {
  HomeCubit({required IDioNexusManager dioNexusManager}) : super(const Idle()) {
    _dioNexusManager = dioNexusManager;
  }

  late IDioNexusManager _dioNexusManager;

  bool isLoading = false;

  Future<void> getUserList() async {
    emit(const ResultState.loading());
    IResponseModel<Users?>? response =
        await _dioNexusManager.sendRequest<Users, Users>(
      "api/users",
      requestType: RequestType.GET,
      responseModel: Users(),
    );
    if (response?.errorModel != null &&
        response!.errorModel!.networkException != null) {
      emit(ResultState.error(error: response.errorModel!.networkException!));
    } else if (response?.model != null) {
      emit(ResultState.data(data: response!.model!));
    }
  }

  /* Future<IResponseModel<SingleUser?>?> getUser() async {
    changeLoading();
    IResponseModel<SingleUser?>? response =
        await dioNexusManager.sendRequest<SingleUser, SingleUser>(
      "api/users/2",
      requestType: RequestType.GET,
      responseModel: SingleUser(),
    );
    print("getUser : ${response?.toString()}");
    changeLoading();
    return response;
  }

  Future<IResponseModel<Users?>?> getUsersWithDelay() async {
    changeLoading();
    IResponseModel<Users?>? response =
        await dioNexusManager.sendRequest<Users, Users>(
      "api/users?delay=2",
      requestType: RequestType.GET,
      responseModel: Users(),
    );
    print("getUsersWithDelay : ${response?.toString()}");
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
    print("registerUnsuccessful : ${response?.toString()}");

    changeLoading();
    return response;
  }*/
}
