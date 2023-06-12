import 'package:dio_nexus/dio_nexus.dart';
import '../model/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRegisterUnSuccessCubit extends Cubit<ResultState<Register>> {
  HomeRegisterUnSuccessCubit({required IDioNexusManager dioNexusManager})
      : super(const Idle()) {
    _dioNexusManager = dioNexusManager;
  }

  late IDioNexusManager _dioNexusManager;

  Future<void> getUserList() async {
    emit(const ResultState.loading());
    IResponseModel<Register?>? response =
        await _dioNexusManager.sendRequest<Register, Register>("api/register",
            requestType: RequestType.POST,
            responseModel: Register(),
            data: Register(email: 'sydney@fife'));
    if (response?.errorModel?.networkException != null) {
      emit(ResultState.error(error: response!.errorModel!.networkException!));
    } else if (response?.model != null) {
      emit(ResultState.data(data: response!.model!));
    } else {
      emit(const ResultState.idle());
    }
  }
}
