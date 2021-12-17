include(FetchContent)

message(STATUS "get yaml-cpp ...")

FetchContent_Declare(
  yaml-cpp
  URL  https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-0.7.0.tar.gz
)

set(BUILD_TESTING OFF CACHE BOOL "")
set(YAML_CPP_BUILD_TESTS OFF CACHE BOOL "")
set(YAML_CPP_BUILD_TOOLS OFF CACHE BOOL "")
set(YAML_CPP_INSTALL OFF CACHE BOOL "")

FetchContent_MakeAvailable(yaml-cpp)

# import targets：
# yaml-cpp::yaml-cpp
