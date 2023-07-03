import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_manager_test/src/feature/home/model/users_model.dart';

import '../../../core/utility/network/network_error_resolver.dart';
import '../cubit/home_user_with_delay_cubit.dart';

class SingleWithDelayWidget extends StatelessWidget {
  const SingleWithDelayWidget({super.key, required this.homeUserDelayCubit});
  final HomeUserDelayCubit homeUserDelayCubit;
  @override
  Widget build(BuildContext context) {
    return _singleUserDelayWidget();
  }

  Widget _singleUserDelayWidget() {
    return BlocBuilder<HomeUserDelayCubit, ResultState<Users>>(
      builder: (BuildContext context, ResultState<Users> state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          idle: () => const Center(child: Text('Not data')),
          data: (Users data) => Center(child: Text(data.data.toString())),
          error: (NetworkExceptions error) {
            return NetworkErrorResolver(error).errorWidget(
              receiveData: () {
                homeUserDelayCubit.getUserDelayList();
              },
            );
          },
        );
      },
    );
  }
}
