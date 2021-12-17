#include <string>

#include "snappy.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  std::string buf;

  std::string s1 = "test msg test msg test msg test msg";
  printf("s1 size : %llu\n", s1.size());

  snappy::Compress(s1.c_str(), s1.size(), &buf);
  printf("buf size : %llu\n", buf.size());

  std::string s2;
  snappy::Uncompress(buf.c_str(), buf.size(), &s2);
  printf("s2 size : %llu\n", s2.size());
  printf("s2 : %s\n", s2.c_str());

  return 0;
}
