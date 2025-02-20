import 'package:dio_nexus/dio_nexus.dart';
import 'package:example/src/core/manager/interceptors/network_interceptor.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => TestViewState();
}

class TestViewState extends State<TestView> {
  late final IDioNexusManager nexus;
  @override
  void initState() {
    super.initState();
    nexus = DioNexusManager(
        printLogsDebugMode: true,
        interceptor: MyInterceptor(),
        options: BaseOptions(
            baseUrl: "http://192.168.1.121:5003/api",
            headers: {'Content-type': 'application/json'},
            receiveTimeout: const Duration(seconds: 15),
            connectTimeout: const Duration(seconds: 15)),
        locale: const Locale('tr'),
        networkConnection: NetworkConnection(
          context: context,
          snackbarDuration: const Duration(seconds: 3),
        ),
        timeoutToast: TimeoutToast(showException: true));
  }

  Future<void> getData() async {
    nexus.addBaseHeader(MapEntry('Authorization',
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI5MWQyMTVhYS1mZjNmLTQ1NGItOTcyMS1mZTA4ZjQ1NGRhY2QiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJzYWZhQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiNDdjMDJiOTktMTEwZS00OGRhLTZmYzYtMDhkZDRkOTE0YTJmIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsIm5iZiI6MTc0MDAzODIyOCwiZXhwIjoxNzQwMDQzNjI4LCJpc3MiOiJ3ZWVmaXQuYXBwIiwiYXVkIjoid2VlZml0LmFwcCJ9.DfHQu2XMtkXfuKWSPTpf-Kf7vKQJtBLFvMoXXl4-Zr0'));
    final response = await nexus.sendPrimitiveRequest<List<String>>(
      '/UserFavoriteFood/GetFavoriteFoodIds',
      requestType: RequestType.GET,
    );
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            await getData();
          },
          child: Center(child: Text('get')),
        ),
      ],
    ));
  }
}
