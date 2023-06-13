import 'package:dio_nexus/dio_nexus.dart';
import '../model/single_user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/home_service.dart';

class HomeSingleUserCubit extends Cubit<ResultState<SingleUser>> {
  HomeSingleUserCubit({required IDioNexusManager dioNexusManager})
      : super(const Idle()) {
    homeService = HomeService(dioNexusManager);
  }
  late HomeService homeService;

  Future<void> getUserList() async {
    emit(const ResultState.loading());
    IResponseModel<SingleUser?>? response = await homeService.getUser(2);
    if (response?.errorModel?.networkException != null) {
      emit(ResultState.error(error: response!.errorModel!.networkException!));
    } else if (response?.model != null) {
      emit(ResultState.data(data: response!.model!));
    } else {
      emit(const ResultState.idle());
    }
  }
}
