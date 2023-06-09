import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'enum/logger_type.dart';

@immutable
class CustomLogger {
  late final LoggerLevel _loggerLevel;
  late final String _data;
  final Logger logger = Logger();
  CustomLogger({required String data, LoggerLevel? loggerLevel}) {
    _loggerLevel = loggerLevel ?? LoggerLevel.Error;
    _data = data;
  }

  void show() {
    switch (_loggerLevel) {
      case LoggerLevel.Verbose:
        logger.v(_data);
        break;
      case LoggerLevel.Debug:
        logger.d(_data);
        break;
      case LoggerLevel.Info:
        logger.i(_data);
        break;
      case LoggerLevel.Warning:
        logger.w(_data);
        break;
      case LoggerLevel.Error:
        logger.e(_data);
        break;
      case LoggerLevel.WTF:
        logger.wtf(_data);
        break;
    }
  }
}
