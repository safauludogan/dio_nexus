import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utility/network/network_error_resolver.dart';
import '../cubit/home_users_cubit.dart';
import '../model/users_model.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({super.key, required this.homeUsersCubit});
  final HomeUsersCubit homeUsersCubit;
  @override
  Widget build(BuildContext context) {
    return _userListWidget();
  }

  Widget _userListWidget() {
    return BlocBuilder<HomeUsersCubit, ResultState<Users>>(
      builder: (BuildContext context, ResultState<Users> state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          idle: () => const Center(child: Text('Not data')),
          data: (Users data) => ListView.builder(
            itemCount: data.data!.length,
            itemBuilder: (context, index) => Center(
              child: Text(
                data.data![index].email.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          error: (NetworkExceptions error) {
            return NetworkErrorResolver(error)
                .errorWidget(receiveData: () => homeUsersCubit.getUserList());
          },
        );
      },
    );
  }
}
