#include <gtest/gtest.h>

#include <vector>

#include "mylib.hpp"

TEST(MYLIB_TEST, Add) {
  struct TestCase {
    std::string name;

    int a;
    int b;

    int want_result;
  };
  std::vector<TestCase> test_cases;
  test_cases.emplace_back(TestCase{
      .name = "case 1",
      .a = 1,
      .b = 2,
      .want_result = 3});
  test_cases.emplace_back(TestCase{
      .name = "case 1",
      .a = 1,
      .b = 0,
      .want_result = 1});

  for (size_t ii = 0; ii < test_cases.size(); ++ii) {
    const TestCase& cur_case = test_cases[ii];
    auto ret = Add(cur_case.a, cur_case.b);
    EXPECT_EQ(ret, cur_case.want_result)
        << "Test " << cur_case.name << " failed, index " << ii;
  }
}
