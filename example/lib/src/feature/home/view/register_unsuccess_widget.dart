import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utility/network/network_error_resolver.dart';
import '../cubit/home_register_unsuccessful_cubit.dart';
import '../model/register.dart';

class RegisterUnSuccessWidget extends StatelessWidget {
  const RegisterUnSuccessWidget(
      {super.key, required this.homeRegisterUnSuccessCubit});
  final HomeRegisterUnSuccessCubit homeRegisterUnSuccessCubit;
  @override
  Widget build(BuildContext context) {
    return _singleUserDelayWidget();
  }

  Widget _singleUserDelayWidget() {
    return BlocBuilder<HomeRegisterUnSuccessCubit, ResultState<Register>>(
      builder: (BuildContext context, ResultState<Register> state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          idle: () => const Center(child: Text('Henüz yok')),
          data: (Register data) => Center(child: Text(data.email.toString())),
          error: (NetworkExceptions error) {
            return NetworkErrorResolver(error).errorWidget(
              receiveData: () {
                homeRegisterUnSuccessCubit.getUserList();
              },
            );
          },
        );
      },
    );
  }
}
