part of '../dio_nexus_manager.dart';

/// The `extension NetworkInterceptor on DioNexusManager` is creating an extension method called
/// `networkInterceptor` on the `DioNexusManager` class. This allows you to call the
/// `networkInterceptor` method directly on an instance of `DioNexusManager` and perform additional
/// operations on it.
extension NetworkInterceptor on DioNexusManager {
  /// The function `networkInterceptor` sets the network interceptor for making HTTP requests.
  ///
  /// Args:
  ///   interceptor (Interceptor): The `interceptor` parameter is of type `Interceptor?`, which means it
  /// can either be an instance of the `Interceptor` class or `null`.
  void networkInterceptor(Interceptor? interceptor) {
    if (interceptor != null) interceptors.add(interceptor);
    interceptors.add(
      QueuedInterceptorsWrapper(
        onError: (e, handler) async {
          final errorResponse = e.response;
          if (errorResponse != null &&
              errorResponse.statusCode != null &&
              errorResponse.statusCode == HttpStatus.unauthorized &&
              onRefreshToken != null) {
            final onRefrestError = await onRefreshToken!(e, options);
            final requestModel = onRefrestError.requestOptions;

            try {
              if (options.baseUrl.isEmpty && requestModel.baseUrl.isNotEmpty) {
                options.baseUrl = requestModel.baseUrl;
              }
              final response =
                  await RetryOptions(maxAttempts: maxAttempts).retry(
                () async => Dio(options).request(
                  requestModel.path,
                  queryParameters: requestModel.queryParameters,
                  data: requestModel.data,
                  options: Options(
                    method: requestModel.method,
                    headers: requestModel.headers,
                  ),
                ),
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
      ),
    );
  }
}
