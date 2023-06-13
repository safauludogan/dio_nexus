import 'package:dio/dio.dart';

class MyInterceptor implements InterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("InterceptorsWrapper");
    return handler.next(response);
  }
}
