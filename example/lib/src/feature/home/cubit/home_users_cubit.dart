import 'package:dio_nexus/dio_nexus.dart';
import '../model/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUsersCubit extends Cubit<ResultState<Users>> {
  HomeUsersCubit({required IDioNexusManager dioNexusManager})
      : super(const Idle()) {
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
    if (response?.errorModel?.networkException != null) {
      emit(ResultState.error(error: response!.errorModel!.networkException!));
    } else if (response?.model != null) {
      emit(ResultState.data(data: response!.model!));
    } else {
      emit(const ResultState.idle());
    }
  }
}
