part of '../dio_nexus_manager.dart';

extension NetworkInterceptor on DioNexusManager {
  void networkInterceptor(Interceptor? interceptor) {
    if (interceptor != null) interceptors.add(interceptor);
    interceptors.add(QueuedInterceptorsWrapper(
      onError: (e, handler) {
        return handler.next(e);
      },
    ));
  }
}
