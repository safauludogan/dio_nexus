import 'package:flutter/material.dart';
import 'package:network_manager_test/src/feature/home/view/register_unsuccess_widget.dart';
import '../../viewmodel/home_viewmodel.dart';
import 'single_user_delay_widget.dart';
import 'single_user_widget.dart';
import 'user_list_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buttonsWrap(),
            _bodyColumn(),
          ],
        ),
      ),
    );
  }

  Widget _bodyColumn() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserListWidget(homeUsersCubit: homeUsersCubit),
          const Divider(color: Colors.red, thickness: 1.5),
          SingleUserWidget(homeSingleUserCubit: homeSingleUserCubit),
          const Divider(color: Colors.red, thickness: 1.5),
          SingleWithDelayWidget(homeUserDelayCubit: homeUserDelayCubit),
          const Divider(color: Colors.red, thickness: 1.5),
          RegisterUnSuccessWidget(
              homeRegisterUnSuccessCubit: homeRegisterUnSuccessCubit)
        ],
      ),
    ));
  }

  Widget _buttonsWrap() {
    return Wrap(
      children: [
        ElevatedButton(
          onPressed: () async => await homeUsersCubit.getUserList(),
          child: const Text('Get User List'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async => await homeSingleUserCubit.getUserList(),
          child: const Text('Get Single User'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async => await homeUserDelayCubit.getUserDelayList(),
          child: const Text('Get Users With Delay'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async => homeRegisterUnSuccessCubit.getUserList(),
          child: const Text('Register Unsuccessful'),
        ),
      ],
    );
  }
}
