import 'package:flutter/foundation.dart';

enum Level { verbose, debug, info, warning, error, nothing }

class LoggerImpl {
  bool _isEnabled = true;
  Level level = Level.verbose;

  // Public methods
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

  // Private helper methods
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

  String _formatStackTrace(StackTrace stackTrace) {
    return stackTrace
        .toString()
        .split('\n')
        .map((line) {
          if (line.contains('LoggerImpl')) return null;
          final match = RegExp(r'package:.*?.dart:\d+').firstMatch(line);
          if (match != null) {
            return '  ${match.group(0)}';
          }
          return null;
        })
        .where((line) => line != null)
        .take(3)
        .join('\n');
  }

  void _log(Level logLevel, String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (!_isEnabled || level == Level.nothing || logLevel.index < level.index) {
      return;
    }

    final time = _getTime();
    final emoji = _getEmoji(logLevel);
    final levelName = _getLevelName(logLevel);
    // final location = _getFileLocation();

    if (kDebugMode) {
      print(''); // Add a blank line for readability
      print('╔═══════════════════════════════════════════════════════════');
      print('║ $time | $emoji $levelName ${tag != null ? '[$tag]' : ''}');
      // print('║ 📍 $location');
      print('║ 💭 $message');

      if (error != null) {
        print('║ ❌ Error: $error');
      }

      if (stackTrace != null) {
        final formattedStack = _formatStackTrace(stackTrace);
        print('║ 📚 Stack trace:');
        formattedStack.split('\n').forEach((line) {
          print('║    $line');
        });
      }

      print('╚═══════════════════════════════════════════════════════════');
      print(''); // Add a blank line for readability
    }
  }

  String _getFileLocation() {
    try {
      final frames = StackTrace.current.toString().split('\n');
      // Skip first frames that contain LoggerImpl and LoggerManager
      int startIndex = 0;
      while (startIndex < frames.length &&
          (frames[startIndex].contains('LoggerImpl') ||
              frames[startIndex].contains('LoggerManager') ||
              frames[startIndex].contains('logger_manager'))) {
        startIndex++;
      }

      for (var i = startIndex; i < frames.length; i++) {
        final frame = frames[i];
        final match = RegExp(r'package:.*?.dart:\d+').firstMatch(frame);
        if (match != null) {
          return match.group(0) ?? 'unknown location';
        }
      }
      return 'unknown location';
    } catch (e) {
      return 'unknown location';
    }
  }
}
