
#include <string>

#include <rapidjson/document.h>
#include <rapidjson/error/en.h>
#include <rapidjson/prettywriter.h>
#include <rapidjson/rapidjson.h>
#include <rapidjson/stringbuffer.h>
#include <rapidjson/writer.h>

using namespace std;

int32_t main(int32_t argc, char** argv) {
  string json_str = R"str(
{
  "key1":"val1",
  "key2":123,
  "key3":123.0,
  "key4":[],
  "key5":{}
}
)str";
  rapidjson::Document document;
  document.Parse(json_str.c_str());

  printf("key1:%s\n", document["key1"].GetString());
  printf("key2:%d\n", document["key2"].GetInt());

  return 0;
}
