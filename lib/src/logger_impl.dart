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
      print(''); // Add a blank line for readability
      print('╔═══════════════════════════════════════════════════════════');
      print('║ $time | $emoji $levelName ${tag != null ? '[$tag]' : ''}');
      print('║ 📍 $location');
      print('║ 💭 $message');

      if (error != null) {
        print('║ ❌ Error: $error');
      }

      if (stackTrace != null) {
        print('║ 📚 Stack trace:');
        Trace.from(stackTrace).frames.take(3).forEach((frame) {
          if (!frame.member!.contains('LoggerImpl')) {
            print('║    at ${frame.member} (${frame.uri}:${frame.line})');
          }
        });
      }

      print('╚═══════════════════════════════════════════════════════════');
      print(''); // Add a blank line for readability
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
