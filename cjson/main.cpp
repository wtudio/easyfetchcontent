#include <cstdio>
#include <iostream>
#include <string>

#include <cJSON.h>

int32_t main(int32_t argc, char** argv) {
  std::string s = R"str({
	"person": {
		"firstName": "w",
		"lastName": "t",
		"age": 18
	}
})str";

  cJSON* root = cJSON_Parse(s.c_str());

  std::cout << root->type << std::endl;

  cJSON_Delete(root);

  return 0;
}
