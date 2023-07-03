import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utility/network/network_error_resolver.dart';
import '../cubit/home_single_user_cubit.dart';
import '../model/single_user_model.dart';

class SingleUserWidget extends StatelessWidget {
  const SingleUserWidget({super.key, required this.homeSingleUserCubit});
  final HomeSingleUserCubit homeSingleUserCubit;
  @override
  Widget build(BuildContext context) {
    return _singleUserWidget();
  }

  Widget _singleUserWidget() {
    return BlocBuilder<HomeSingleUserCubit, ResultState<SingleUser>>(
      builder: (BuildContext context, ResultState<SingleUser> state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          idle: () => const Center(child: Text('Not data')),
          data: (SingleUser data) => Center(child: Text(data.data.toString())),
          error: (NetworkExceptions error) {
            return NetworkErrorResolver(error).errorWidget(receiveData: () {
              homeSingleUserCubit.getUserList();
            });
          },
        );
      },
    );
  }
}
