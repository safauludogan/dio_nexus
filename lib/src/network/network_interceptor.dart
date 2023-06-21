part of '../dio_nexus_manager.dart';

extension NetworkInterceptor on DioNexusManager {
  void networkInterceptor(Interceptor? interceptor) {
    if (interceptor != null) interceptors.add(interceptor);
    interceptors.add(QueuedInterceptorsWrapper(
      onError: (e, handler) async {
        final errorResponse = e.response;
        if (errorResponse != null &&
            errorResponse.statusCode != null &&
            errorResponse.statusCode == HttpStatus.unauthorized &&
            onRefreshToken != null) {
          DioException onRefrestError = await onRefreshToken!(e, options);
          final requestModel = onRefrestError.requestOptions;

          try {
            if (options.baseUrl.isEmpty && requestModel.baseUrl.isNotEmpty) {
              options.baseUrl = requestModel.baseUrl;
            }
            var response = await RetryOptions(maxAttempts: maxAttempts).retry(
              () async => await Dio(options).request(requestModel.path,
                  queryParameters: requestModel.queryParameters,
                  data: requestModel.data,
                  options: Options(
                      method: requestModel.method,
                      headers: requestModel.headers)),
              retryIf: (e) => e is SocketException || e is TimeoutException,
            );
            return handler.resolve(response);
          } on DioException catch (error) {
            if (error.response?.statusCode == HttpStatus.unauthorized) {
              onRefreshFail?.call();
              return handler.next(e);
            }
            return handler.next(error);
          }
        }
        return handler.next(e);
      },
    ));
  }
}
