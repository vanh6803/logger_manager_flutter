# logger_manager

A comprehensive logging utility for Flutter applications that provides beautiful and well-formatted logs with file locations, stack traces, and different log levels.

## Features

- 📝 Multiple log levels (Verbose, Debug, Info, Warning, Error)
- 📍 Automatic file and line number detection
- 🎯 Custom tags for better log organization
- 🎨 Beautiful console output with emojis and formatting
- ⚡ Stack trace support for error logs
- 🎮 Easy to use global functions
- ⚙️ Enable/Disable logging functionality

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  logger_manager:
    git:
      url: https://github.com/vanh6803/logger_manager_flutter.git
      ref: main  # or specific branch/tag
```

or
```yaml
dependencies:
  logger_manager:
    path: path/to/logger_manager
```

## Usage

### Basic Usage

- import package
```dart
import 'package:logger_manager/logger_manager.dart';
```

- use log functions
```dart
void main() {
  // Enable logging (enabled by default)
  LoggerManager.enable();

  // Basic logging
  logd('Debug message');
  logi('Info message');
  logw('Warning message');
  loge('Error message');
  logv('Verbose message');

  // Logging with tags
  logd('User logged in', tag: 'Auth');
  logi('Payment processed', tag: 'Payment');

  // Logging errors with stack traces
  try {
    throw Exception('Something went wrong');
  } catch (e, stackTrace) {
    loge('Error occurred', 
      error: e, 
      stackTrace: stackTrace, 
      tag: 'Error');
  }
}
```

### Log Output Example

```
╔═══════════════════════════════════════════════════════════
║ 14:30:45.123 | 🐛 DEBUG [Auth]
║ 📍 package:your_app/main.dart:25:10
║ 💭 User logged in
╚═══════════════════════════════════════════════════════════

╔═══════════════════════════════════════════════════════════
║ 14:30:45.124 | ⛔ ERROR [Error]
║ 📍 package:your_app/main.dart:34:12
║ 💭 Error occurred
║ ❌ Error: Exception: Something went wrong
║ 📚 Stack trace:
║    at main (package:your_app/main.dart:33:5)
║    at _AsyncRun._asyncStartSync (dart:async-patch/async_patch.dart:18:14)
║    at _AsyncRun._asyncStart (dart:async-patch/async_patch.dart:31:19)
╚═══════════════════════════════════════════════════════════
```

### Log Levels

- 🗣 `logv`: Verbose - detailed information, typically for debugging
- 🐛 `logd`: Debug - debugging information during development
- 💡 `logi`: Info - general information about program execution
- ⚠️ `logw`: Warning - potentially harmful situations
- ⛔ `loge`: Error - errors that might still allow the application to continue running

### Enabling/Disabling Logs

```dart
// Disable all logs
LoggerManager.disable();

// Enable logs again
LoggerManager.enable();
```

### Direct Usage Without Shortcuts

```dart
// Without using shortcuts
LoggerManager.d('Debug message');
LoggerManager.i('Info message');
LoggerManager.w('Warning message');
LoggerManager.e('Error message');
LoggerManager.v('Verbose message');
```

## Contributing

Contributions are welcome! Feel free to:
- Open issues for bugs or feature requests
- Submit pull requests
- Improve documentation
- Share feedback

## Support

If you have any questions or need help, feel free to:
- Open an [issue](https://github.com/vanh-flutter/logger_manager/issues)
- Contact me at anhnv6083@gmail.com

## License

```
Copyright (c) 2024 Nguyen Viet Anh (vanh-flutter)
```