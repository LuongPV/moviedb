
import 'package:logger/logger.dart' as logger_library;

import 'log_printer.dart';

class Logger {
  static final Logger _instance = Logger._internal();
  final _nativeLogger = logger_library.Logger(
    printer: SimpleLogPrinter(),
  );

  factory Logger() {
    return _instance;
  }

  Logger._internal();

  static void v(dynamic message, [dynamic error, StackTrace stackTrace]) {
    _instance._nativeLogger.v(message, error, stackTrace);
  }

  static void d(dynamic message, [dynamic error, StackTrace stackTrace]) => _instance._nativeLogger.d(message, error, stackTrace);

  static void i(dynamic message, [dynamic error, StackTrace stackTrace]) => _instance._nativeLogger.i(message, error, stackTrace);

  static void w(dynamic message, [dynamic error, StackTrace stackTrace]) => _instance._nativeLogger.w(message, error, stackTrace);

  static void e(dynamic message, [dynamic error, StackTrace stackTrace]) => _instance._nativeLogger.e(message, error, stackTrace);

  static void wtf(dynamic message, [dynamic error, StackTrace stackTrace]) => _instance._nativeLogger.wtf(message, error, stackTrace);

}