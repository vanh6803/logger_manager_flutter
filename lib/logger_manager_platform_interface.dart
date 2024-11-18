import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'logger_manager_method_channel.dart';

abstract class LoggerManagerPlatform extends PlatformInterface {
  LoggerManagerPlatform() : super(token: _token);
  static final Object _token = Object();
  static LoggerManagerPlatform _instance = MethodChannelLoggerManager();
  static LoggerManagerPlatform get instance => _instance;

  static set instance(LoggerManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void enable() {
    throw UnimplementedError('enable() has not been implemented.');
  }

  void disable() {
    throw UnimplementedError('disable() has not been implemented.');
  }

  void d(String message, {String? tag}) {
    throw UnimplementedError('debug() has not been implemented.');
  }

  void i(String message, {String? tag}) {
    throw UnimplementedError('info() has not been implemented.');
  }

  void w(String message, {String? tag}) {
    throw UnimplementedError('warning() has not been implemented.');
  }

  void e(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    throw UnimplementedError('error() has not been implemented.');
  }

  void v(String message, {String? tag}) {
    throw UnimplementedError('verbose() has not been implemented.');
  }
}
