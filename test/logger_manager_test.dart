// import 'package:flutter_test/flutter_test.dart';
// import 'package:logger_manager/logger_manager.dart';
// import 'package:logger_manager/logger_manager_platform_interface.dart';
// import 'package:logger_manager/logger_manager_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockLoggerManagerPlatform
//     with MockPlatformInterfaceMixin
//     implements LoggerManagerPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final LoggerManagerPlatform initialPlatform = LoggerManagerPlatform.instance;
//
//   test('$MethodChannelLoggerManager is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelLoggerManager>());
//   });
//
//   test('getPlatformVersion', () async {
//     LoggerManager loggerManagerPlugin = LoggerManager();
//     MockLoggerManagerPlatform fakePlatform = MockLoggerManagerPlatform();
//     LoggerManagerPlatform.instance = fakePlatform;
//
//     expect(await loggerManagerPlugin.getPlatformVersion(), '42');
//   });
// }
