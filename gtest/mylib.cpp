#include "mylib.hpp"

#include <string>

int Add(int a, int b) {
  return a + b;
}

int Sub(int a, int b) {
  return a - b;
}

std::string Foo(int i) {
  if (i == 0) return "Foo";
  return "Bar";
}
