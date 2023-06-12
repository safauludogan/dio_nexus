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
      "api/users?delay=5",
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
}
