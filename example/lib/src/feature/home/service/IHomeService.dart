import 'package:dio_nexus/dio_nexus.dart';

import '../model/register.dart';
import '../model/single_user_model.dart';
import '../model/users_model.dart';

abstract class IHomeService {
  IDioNexusManager nexusManager;
  IHomeService(this.nexusManager);
  Future<IResponseModel<Register?>?> register(Register register);
  Future<IResponseModel<SingleUser?>?> getUser(int page);
  Future<IResponseModel<Users?>?> getUsersWithDelay(int delayTime);
  Future<IResponseModel<Users?>?> getUsers();
}
