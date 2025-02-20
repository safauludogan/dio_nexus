import 'package:dio_nexus/src/languages/index.dart';

/// The `LanguageEn` class extends the `Languages` abstract class and provides the English language translations.
class LanguageEn extends Languages {
  @override
  String get networkConnectionNoInternetConnection => 'No internet connection';

  @override
  String get networkConnectionTryAgain => 'Try Again';

  @override
  String get notImplemented => 'Not Implemented';

  @override
  String get requestCancelled => 'Request Cancelled';

  @override
  String get internalServerError => 'Internal Server Error';

  @override
  String get notFound => 'Not found!';

  @override
  String get serviceUnavailable => 'Service unavailable';

  @override
  String get methodNotAllowed => 'Method Not Allowed';

  @override
  String get badRequest => 'Bad request';

  @override
  String get unauthorizedRequest => 'Unauthorized request';

  @override
  String get unexpectedError => 'Unexpected error occurred';

  @override
  String get requestTimeout => 'Connection failed. Weak internet connection';

  @override
  String get conflict => 'Error due to a conflict';

  @override
  String get sendTimeout => 'Data Transmission Timeout';

  @override
  String get unableToProcess => 'Unable to process the data';

  @override
  String get formatException => 'Unexpected error occurred';

  @override
  String get notAcceptable => 'Not acceptable';

  @override
  String get badCertificate => 'Invalid or Untrusted SSL/TLS certificate';

  @override
  String get connectionError =>
      "Couldn't establish a connection for the request";

  @override
  String get receiveTimeout => 'Server unresponsive. Please retry';

  @override
  String get forbiddenRequest => 'Forbidden Request';

  @override
  String get rateLimitExceeded => 'Rate limit exceeded';
  
  @override
  String get badGateway => 'Bad Gateway: Server received an invalid response';
  
  @override
  String get gatewayTimeout => 'Gateway Timeout: Server failed to respond in time';
}
