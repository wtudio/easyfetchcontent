#include <string>

#include "spdlog/spdlog.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  spdlog::info("Welcome to spdlog!");
  spdlog::error("Some error message with arg: {}", 1);

  spdlog::warn("Easy padding in numbers like {:08d}", 12);
  spdlog::critical("Support for int: {0:d};  hex: {0:x};  oct: {0:o}; bin: {0:b}", 42);
  spdlog::info("Support for floats {:03.2f}", 1.23456);
  spdlog::info("Positional args are {1} {0}..", "too", "supported");
  spdlog::info("{:<30}", "left aligned");

  spdlog::set_level(spdlog::level::debug);  // Set global log level to debug
  spdlog::debug("This message should be displayed..");

  // change log pattern, see https://spdlog.docsforge.com/v1.x/3.custom-formatting/#pattern-flags
  spdlog::set_pattern("%^[%Y-%m-%d %T.%f][%l][%t][%g:%#@%!]%v%$");

  // Compile time log levels
  // define SPDLOG_ACTIVE_LEVEL to desired level
  SPDLOG_TRACE("Some trace message with param {}", 42);
  SPDLOG_DEBUG("Some debug message");
  SPDLOG_INFO("Some info message");
  SPDLOG_WARN("Some warn message");
  SPDLOG_ERROR("Some error message");

  return 0;
}
