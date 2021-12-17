#include <filesystem>
#include <fstream>
#include <string>

#include "yaml-cpp/yaml.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  const std::filesystem::path& yaml_file = std::filesystem::absolute("./test.yaml");

  std::ofstream ofile(yaml_file, std::ios::trunc);
  ofile << R"str(
obj1:
  key1: value1
  key2: value2
  array:
  - null_value: 
  - boolean: true
  - integer: 1
  array2: [1,2,3,4,5]
  array3:
  - 1
  - 2
  - 3
obj2:
- key1: value1
- key2: value2
)str";
  ofile.close();

  YAML::Node config;

  try {
    config = YAML::LoadFile(yaml_file.string());
  } catch (const YAML::BadFile& e) {
    printf("YAML::LoadFile failed, %s\n", e.what());
    return 0;
  }

  try {
    std::string val = config["obj1"]["key1"].as<string>();
    printf("obj1.key1 = %s\n", val.c_str());

    val = config["obj1"]["key2"].as<string>();
    printf("obj1.key2 = %s\n", val.c_str());

    std::vector<int> int_arr2 = config["obj1"]["array2"].as<std::vector<int>>();
    printf("obj1.array2 size = %llu\n", int_arr2.size());

    std::vector<int> int_arr3 = config["obj1"]["array3"].as<std::vector<int>>();
    printf("obj1.array3 size = %llu\n", int_arr3.size());

  } catch (const std::exception& e) {
    printf("YAML read failed, %s\n", e.what());
  }

  return 0;
}
