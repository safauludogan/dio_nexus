import 'package:example/src/feature/home/cubit/home_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/core/manager/network_manager.dart';
import 'src/feature/home/cubit/home_register_unsuccessful_cubit.dart';
import 'src/feature/home/cubit/home_single_user_cubit.dart';
import 'src/feature/home/cubit/home_user_with_delay_cubit.dart';
import 'src/feature/home/view/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: multiProviders(),
    );
  }

  MultiBlocProvider multiProviders() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            NetworkManager.instance.init(context);
            return HomeUsersCubit(
                dioNexusManager: NetworkManager.instance.networkManager);
          },
        ),
        BlocProvider(
          create: (context) {
            NetworkManager.instance.init(context);
            return HomeSingleUserCubit(
                dioNexusManager: NetworkManager.instance.networkManager);
          },
        ),
        BlocProvider(
          create: (context) {
            NetworkManager.instance.init(context);
            return HomeUserDelayCubit(
                dioNexusManager: NetworkManager.instance.networkManager);
          },
        ),
        BlocProvider(
          create: (context) {
            NetworkManager.instance.init(context);
            return HomeRegisterUnSuccessCubit(
                dioNexusManager: NetworkManager.instance.networkManager);
          },
        ),
      ],
      child: const HomeView(),
    );
  }
}
