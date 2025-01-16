import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

enum Level { verbose, debug, info, warning, error, nothing }

class LoggerImpl {
  bool _isEnabled = true;
  Level level = Level.verbose;

  String _getFileLocation() {
    try {
      final trace = StackTrace.current.toString();
      final frames = trace.split('\n');

      for (var frame in frames) {
        frame = frame.trim();
        // Tìm frame có format "#<number>      <method> (package:...)"
        if (frame.contains('(package:')) {
          // Lấy phần path trong dấu ngoặc đơn
          final pathMatch = RegExp(r'\(package:(.*?)\)').firstMatch(frame);
          if (pathMatch != null) {
            final path = pathMatch.group(1);
            // Kiểm tra path không bắt đầu với logger_manager hoặc flutter
            if (path != null &&
                !path.startsWith('logger_manager/') &&
                !path.startsWith('flutter/') &&
                !path.startsWith('dart:')) {
              return 'package:$path';
            }
          }
        }
      }
      return 'unknown location';
    } catch (e) {
      return 'unknown location';
    }
  }

  String _getEmoji(Level logLevel) {
    switch (logLevel) {
      case Level.verbose:
        return '🗣';
      case Level.debug:
        return '🐛';
      case Level.info:
        return '💡';
      case Level.warning:
        return '⚠️';
      case Level.error:
        return '⛔';
      default:
        return '';
    }
  }

  String _getLevelName(Level logLevel) {
    return logLevel.toString().split('.').last.toUpperCase();
  }

  String _getTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:"
        "${now.minute.toString().padLeft(2, '0')}:"
        "${now.second.toString().padLeft(2, '0')}."
        "${now.millisecond.toString().padLeft(3, '0')}";
  }

  // Hàm để map Level của bạn sang các mức log của developer.log
  int _mapLevel(Level logLevel) {
    switch (logLevel) {
      case Level.verbose:
        return 500;
      case Level.debug:
        return 700;
      case Level.info:
        return 800;
      case Level.warning:
        return 900;
      case Level.error:
        return 1000;
      default:
        return 800;
    }
  }

  void _log(Level logLevel, String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (!_isEnabled || level == Level.nothing || logLevel.index < level.index) {
      return;
    }

    final time = _getTime();
    final emoji = _getEmoji(logLevel);
    final levelName = _getLevelName(logLevel);
    final location = _getFileLocation();

    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln("");
      buffer.writeln('╔═══════════════════════════════════════════════════════════');
      buffer.writeln('║ $time | $emoji $levelName ${tag != null ? '[$tag]' : ''}');
      buffer.writeln('║ 📍 $location');
      buffer.writeln('║ 💭 $message');

      if (error != null) {
        buffer.writeln('║ ❌ Error: $error');
      }

      if (stackTrace != null) {
        buffer.writeln('║ 📚 Stack trace:');
        Trace.from(stackTrace).frames.take(3).forEach((frame) {
          if (!frame.member!.contains('LoggerImpl')) {
            buffer.writeln('║    at ${frame.member} (${frame.uri}:${frame.line})');
          }
        });
      }

      buffer.writeln('╚═══════════════════════════════════════════════════════════');

      // Sử dụng developer.log với thông điệp đã được định dạng
      developer.log(
        buffer.toString(),
        level: _mapLevel(logLevel),
        name: 'Logger',
      );
    }
  }

  void enable() {
    _isEnabled = true;
    level = Level.verbose;
  }

  void disable() {
    _isEnabled = false;
    level = Level.nothing;
  }

  void d(String message, {String? tag}) => _log(Level.debug, message, tag: tag);

  void i(String message, {String? tag}) => _log(Level.info, message, tag: tag);

  void w(String message, {String? tag}) =>
      _log(Level.warning, message, tag: tag);

  void e(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) =>
      _log(Level.error, message,
          tag: tag, error: error, stackTrace: stackTrace);

  void v(String message, {String? tag}) =>
      _log(Level.verbose, message, tag: tag);
}