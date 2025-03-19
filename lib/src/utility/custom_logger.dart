import 'package:dio_nexus/src/utility/enum/logger_type.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

@immutable

/// [CustomLogger] is a class that is used to log messages.
class CustomLogger {
  CustomLogger({required String data, LoggerLevel? loggerLevel}) {
    _loggerLevel = loggerLevel ?? LoggerLevel.Error;
    _data = data;
  }

  /// [loggerLevel] is a variable that is used to log messages.
  late final LoggerLevel _loggerLevel;

  /// [data] is a variable that is used to log messages.
  late final String _data;

  /// [logger] is a variable that is used to log messages.
  final Logger logger = Logger();

  /// [show] is a method that is used to log messages.
  void show({bool? printLog}) {
    if (printLog == null || !printLog) return;
    switch (_loggerLevel) {
      /// [Verbose] is a variable that is used to log messages.
      case LoggerLevel.Verbose:
        logger.v(_data);

      /// [Debug] is a variable that is used to log messages.
      case LoggerLevel.Debug:
        logger.d(_data);

      /// [Info] is a variable that is used to log messages.
      case LoggerLevel.Info:
        logger.i(_data);

      /// [Warning] is a variable that is used to log messages.
      case LoggerLevel.Warning:
        logger.w(_data);

      /// [Error] is a variable that is used to log messages.
      case LoggerLevel.Error:
        logger.e(_data);

      /// [WTF] is a variable that is used to log messages.
      case LoggerLevel.WTF:
        logger.v(_data);
    }
  }
}
