import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/users_model.dart';

class HomeUserDelayCubit extends Cubit<ResultState<Users>> {
  HomeUserDelayCubit({required IDioNexusManager dioNexusManager})
      : super(const Idle()) {
    _dioNexusManager = dioNexusManager;
  }

  late IDioNexusManager _dioNexusManager;

  Future<void> getUserDelayList() async {
    emit(const ResultState.loading());
    IResponseModel<Users?>? response =
        await _dioNexusManager.sendRequest<Users, Users>(
      "api/users?delay=1",
      requestType: RequestType.GET,
      responseModel: Users(),
    );
    if (response?.errorModel?.networkException != null) {
      emit(ResultState.error(error: response!.errorModel!.networkException!));
    } else if (response?.model != null) {
      emit(ResultState.data(data: response!.model!));
    } else {
      emit(const ResultState.idle());
    }
  }

  /*

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
