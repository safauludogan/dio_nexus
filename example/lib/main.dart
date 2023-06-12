import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_manager_test/src/feature/home/cubit/home_cubit.dart';

import 'src/core/manager/network_manager.dart';
import 'src/feature/home/view/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              NetworkManager.instance.init(context);
              return HomeCubit(
                  dioNexusManager: NetworkManager.instance.networkManager);
            },
          )
        ],
        child: const HomeView(),
      ),
    );
  }
}
