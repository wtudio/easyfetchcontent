#include <iostream>

#include "inja/inja.hpp"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  inja::json data;
  data["name"] = "world";

  inja::render("Hello {{ name }}!", data);                // Returns std::string "Hello world!"
  inja::render_to(std::cout, "Hello {{ name }}!", data);  // Writes "Hello world!" to stream

  return 0;
}
