import 'logger_manager_platform_interface.dart';

export 'src/logger_shortcuts.dart';

class LoggerManager {
  static void enable() => LoggerManagerPlatform.instance.enable();
  static void disable() => LoggerManagerPlatform.instance.disable();
  static void d(String message, {String? tag}) =>
      LoggerManagerPlatform.instance.d(message, tag: tag);
  static void i(String message, {String? tag}) =>
      LoggerManagerPlatform.instance.i(message, tag: tag);
  static void w(String message, {String? tag}) =>
      LoggerManagerPlatform.instance.w(message, tag: tag);
  static void e(String message,
          {String? tag, dynamic error, StackTrace? stackTrace}) =>
      LoggerManagerPlatform.instance
          .e(message, tag: tag, error: error, stackTrace: stackTrace);
  static void v(String message, {String? tag}) =>
      LoggerManagerPlatform.instance.v(message, tag: tag);
  Future<String?> getPlatformVersion() {
    return LoggerManagerPlatform.instance.getPlatformVersion();
  }
}
