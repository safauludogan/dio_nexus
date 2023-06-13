import 'package:dio_nexus/dio_nexus.dart';
import 'package:network_manager_test/src/feature/home/service/home_service.dart';
import '../model/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/IHomeService.dart';

class HomeRegisterUnSuccessCubit extends Cubit<ResultState<Register>> {
  HomeRegisterUnSuccessCubit({required IDioNexusManager dioNexusManager})
      : super(const Idle()) {
    homeService = HomeService(dioNexusManager);
  }

  late IHomeService homeService;
  Future<void> getUserList() async {
    emit(const ResultState.loading());
    IResponseModel<Register?>? response =
        await homeService.register(Register(email: 'sydney@fife'));
    if (response?.errorModel?.networkException != null) {
      emit(ResultState.error(error: response!.errorModel!.networkException!));
    } else if (response?.model != null) {
      emit(ResultState.data(data: response!.model!));
    } else {
      emit(const ResultState.idle());
    }
  }
}
