#include <string>

#include "robin_hood.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  robin_hood::unordered_map<int, string> test_map;
  test_map.emplace(1, "111");
  test_map.emplace(2, "222");

  printf("test_map[1]:%s\n", test_map[1].c_str());
  printf("test_map[2]:%s\n", test_map[2].c_str());

  robin_hood::unordered_set<int> test_set;
  test_set.insert(1);
  test_set.insert(2);
  printf("test_set.size():%llu\n", test_set.size());

  return 0;
}
