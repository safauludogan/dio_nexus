import 'package:dio_nexus/src/utility/enum/logger_type.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

@immutable

/// The CustomLogger class is used for logging messages.
class CustomLogger {
  /// The CustomLogger function is used to create a custom logger with optional logger level.
  ///
  /// Args:
  ///   data (String): A required parameter of type String that represents the data to be logged. This
  /// parameter is mandatory and must be provided when creating an instance of the CustomLogger class.
  ///   loggerLevel (LoggerLevel): The loggerLevel parameter is an optional parameter of type
  /// LoggerLevel. It is used to specify the level of logging for the CustomLogger. If no value is
  /// provided for loggerLevel, the default level will be used.
  CustomLogger({required String data, LoggerLevel? loggerLevel}) {
    _loggerLevel = loggerLevel ?? LoggerLevel.Error;
    _data = data;
  }
  late final LoggerLevel _loggerLevel;
  late final String _data;
  final Logger logger = Logger();

  void show(bool? printLog) {
    if (printLog == null || !printLog) return;
    switch (_loggerLevel) {
      case LoggerLevel.Verbose:
        logger.t(_data);
      case LoggerLevel.Debug:
        logger.d(_data);
      case LoggerLevel.Info:
        logger.i(_data);
      case LoggerLevel.Warning:
        logger.w(_data);
      case LoggerLevel.Error:
        logger.e(_data);
      case LoggerLevel.WTF:
        logger.f(_data);
    }
  }
}
