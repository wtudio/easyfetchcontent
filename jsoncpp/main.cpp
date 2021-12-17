#include <string>

#include "json/json.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  const std::string str = R"({"Age": 20, "Name": "colin"})";

  Json::Value root;
  Json::CharReaderBuilder builder;
  JSONCPP_STRING err;

  const std::unique_ptr<Json::CharReader> reader(builder.newCharReader());
  if (!reader->parse(str.c_str(), str.c_str() + str.length(), &root, &err)) {
    printf("error");
    return 0;
  }

  const std::string name = root["Name"].asString();
  printf("name = %s\n", name.c_str());

  const int age = root["Age"].asInt();
  printf("age = %d\n", age);

  return 0;
}
