#include <iostream>

#include <pybind11/functional.h>
#include "pybind11/pybind11.h"

int add(int i, int j) {
  return i + j;
}

void inadd() {
  int a, b;
  std::cin >> a >> b;
  std::cout << a + b;
}

void call_function(const std::function<std::string(int)> &func) {
  std::string result = func(10);
  std::cout << result << std::endl;
}

class TestClass {
 public:
  TestClass() {
    std::cout << "construct" << std::endl;
  }
  ~TestClass() {
    std::cout << "destroy" << std::endl;
  }

  void setName(const std::string &name) { name_ = name; }
  const std::string &getName() const { return name_; }

 private:
  int a_;
  std::string name_ = "init name";
};

namespace py = pybind11;

PYBIND11_MODULE(TestPybind11, m) {
  m.doc() = "pybind11 example plugin";

  m.def("add", &add, "A function which adds two numbers");

  m.def("inadd", &inadd, "cin and count");

  m.def("call_function", &call_function);

  py::class_<TestClass>(m, "TestClass")
      .def(py::init<>())
      .def("setName", &TestClass::setName)
      .def("getName", &TestClass::getName);
}
