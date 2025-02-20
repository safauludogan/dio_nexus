import 'package:dio_nexus/dio_nexus.dart';
import 'package:example/src/feature/home/service/IHomeService.dart';
import 'package:example/src/feature/home/service/home_service.dart';
import '../model/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeUsersCubit extends Cubit<ResultState<Users>> {
  HomeUsersCubit({required IDioNexusManager dioNexusManager})
      : super(const Idle()) {
    homeService = HomeService(dioNexusManager);
  }

  late IHomeService homeService;
  bool isLoading = false;

  Future<void> getUserList() async {
    emit(const ResultState.loading());
    IResponseModel<Users?>? response = await homeService.getUsers();
    if (response?.errorModel?.networkException != null) {
      emit(ResultState.error(error: response!.errorModel!.networkException!));
    } else if (response?.data != null) {
      emit(ResultState.data(data: response!.data!));
    } else {
      emit(const ResultState.idle());
    }
  }
}
