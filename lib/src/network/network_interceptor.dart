import '../../dio_nexus.dart';

extension NetworkInterceptor on DioNexusManager {
  void networkInterceptor(Interceptor? interceptor) {
    if (interceptor != null) interceptors.add(interceptor);
    interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        print("QueuedInterceptorsWrapper");
        return handler.next(options);
      },
      onResponse: (e, handler) {
        return handler.next(e);
      },
      onError: (e, handler) {
        try {
          return handler.next(e);
        } catch (_) {
          return handler.next(e);
        }
      },
    ));
  }
}
