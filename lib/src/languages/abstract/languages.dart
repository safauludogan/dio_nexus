import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get networkConnectionTryAgain;
  String get networkConnectionNoInternetConnection;
  String get notImplemented;
  String get requestCancelled;
  String get internalServerError;
  String get notFound;
  String get serviceUnavailable;
  String get methodNotAllowed;
  String get badRequest;
  String get unauthorisedRequest;
  String get unexpectedError;
  String get requestTimeout;
  String get conflict;
  String get sendTimeout;
  String get unableToProcess;
  String get formatException;
  String get notAcceptable;
  String get badCertificate;
  String get connectionError;
  String get receiveTimeout;
  String get forbiddenRequest;
}
