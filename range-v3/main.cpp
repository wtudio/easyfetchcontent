#include <iostream>
#include <range/v3/all.hpp>
#include <string>

int main(int argc, char **argv) {
  std::string s{"hello"};

  // output: h e l l o
  ranges::for_each(s, [](char c) { std::cout << c << ' '; });
  std::cout << '\n';

  return 0;
}
