#include "include/logger_manager/logger_manager_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "logger_manager_plugin.h"

void LoggerManagerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  logger_manager::LoggerManagerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
