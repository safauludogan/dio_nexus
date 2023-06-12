import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/cubit/home_single_user_cubit.dart';
import '../home/cubit/home_user_with_delay_cubit.dart';
import '../home/cubit/home_users_cubit.dart';
import '../home/view/home_view.dart';

abstract class HomeViewModel extends State<HomeView> {
  late HomeUsersCubit homeUsersCubit;
  late HomeSingleUserCubit homeSingleUserCubit;
  late HomeUserDelayCubit homeUserDelayCubit;
  @override
  void initState() {
    super.initState();
    homeUsersCubit = BlocProvider.of<HomeUsersCubit>(context);
    homeSingleUserCubit = BlocProvider.of<HomeSingleUserCubit>(context);
    homeUserDelayCubit = BlocProvider.of<HomeUserDelayCubit>(context);
  }
}
