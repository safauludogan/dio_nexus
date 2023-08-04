import 'abstract/languages.dart';

class LanguageEn extends Languages {
  @override
  String get networkConnectionNoInternetConnection => "No internet connection";

  @override
  String get networkConnectionTryAgain => "Try Again";
  
  @override
  String get notImplemented => "Not Implemented";
  
  @override
  String get requestCancelled => "Request Cancelled";
  
  @override
  String get internalServerError => "Internal Server Error";
  
  @override
  String get notFound => "Not found!";
  
  @override
  String get serviceUnavailable => "Service unavailable";
  
  @override
  String get methodNotAllowed => "Method Not Allowed";
  
  @override
  String get badRequest => "Bad request";
  
  @override
  String get unauthorisedRequest => "Unauthorised request";
  
  @override
  String get unexpectedError => "Unexpected error occurred";
  
  @override
  String get requestTimeout => "Connection failed. Weak internet connection";
  
  @override
  String get conflict => "Error due to a conflict";
  
  @override
  String get sendTimeout => "Data Transmission Timeout";
  
  @override
  String get unableToProcess => "Unable to process the data";
  
  @override
  String get formatException => "Unexpected error occurred";
  
  @override
  String get notAcceptable => "Not acceptable";
  
  @override
  String get badCertificate => "Invalid or Untrusted SSL/TLS certificate";
  
  @override
  String get connectionError => "Couldn't establish a connection for the request";
  
  @override
  String get receiveTimeout => "Server unresponsive. Please retry";
  
  @override
  // TODO: implement forbiddenRequest
  String get forbiddenRequest => "Forbidden Request";
}
