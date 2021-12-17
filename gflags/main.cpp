#include <cstdio>

#include "gflags/gflags.h"

DEFINE_string(cfgfile, "./testcfg.txt", "config file path");

using namespace std;

const std::string& GetVersion() {
  const static std::string version = "0.1.2.3456";
  return version;
}

const std::string& GetHelp() {
  const static std::string help_info = "This is a test";
  return help_info;
}

int32_t main(int32_t argc, char** argv) {
  gflags::SetVersionString(GetVersion());
  gflags::SetUsageMessage(GetHelp());

  gflags::ParseCommandLineFlags(&argc, &argv, true);
  printf("cfgfile : %s", FLAGS_cfgfile.c_str());

  gflags::ShutDownCommandLineFlags();

  return 0;
}
