import '../../dio_nexus.dart';

extension NetworkInterceptor on DioNexusManager {
  QueuedInterceptorsWrapper networkInterceptor() {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
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
    );
  }
}
