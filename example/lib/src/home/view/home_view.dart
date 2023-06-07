import 'package:flutter/material.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewmodel {
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
                      )
                    ],
                  )
                : const CircularProgressIndicator()));
  }
}
