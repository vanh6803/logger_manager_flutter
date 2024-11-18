import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logger_manager/src/logger_impl.dart';

import 'logger_manager_platform_interface.dart';

/// An implementation of [LoggerManagerPlatform] that uses method channels.
class MethodChannelLoggerManager extends LoggerManagerPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('logger_manager');
  final _logger = LoggerImpl();

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  void enable() => _logger.enable();

  @override
  void disable() => _logger.disable();

  @override
  void d(String message, {String? tag}) => _logger.d(message, tag: tag);

  @override
  void i(String message, {String? tag}) => _logger.i(message, tag: tag);

  @override
  void w(String message, {String? tag}) => _logger.w(message, tag: tag);

  @override
  void e(String message,
          {String? tag, dynamic error, StackTrace? stackTrace}) =>
      _logger.e(message, tag: tag, error: error, stackTrace: stackTrace);

  @override
  void v(String message, {String? tag}) => _logger.v(message, tag: tag);
}
