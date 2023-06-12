import 'package:dio_nexus/dio_nexus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utility/network/network_error_resolver.dart';
import '../model/users_model.dart';
import '../cubit/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeCubit homeCubit;
  @override
  void initState() {
    super.initState();
    homeCubit = BlocProvider.of<HomeCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async => await homeCubit.getUserList(),
              child: const Text('Get User List'),
            ),
            Expanded(
              child: BlocBuilder<HomeCubit, ResultState<Users>>(
                builder: (BuildContext context, ResultState<Users> state) {
                  return state.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    idle: () => const Center(child: Text('Henüz yok')),
                    data: (Users data) =>
                        Center(child: Text(data.data.toString())),
                    error: (NetworkExceptions error) {
                      return NetworkErrorResolver(error).errorWidget();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: isLoading == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async => await getUserList(),
                        child: const Text('Get User List'),
                      ),
                      ElevatedButton(
                        onPressed: () async => await getUser(),
                        child: const Text('Get Single User'),
                      ),
                      ElevatedButton(
                        onPressed: () async => await getUsersWithDelay(),
                        child: const Text('Get Users With Delay'),
                      ),
                      ElevatedButton(
                        onPressed: () async => await registerUnsuccessful(),
                        child: const Text('Register Unsuccessful'),
                      ),
                    ],
                  )
                : const CircularProgressIndicator()));
  }
*/