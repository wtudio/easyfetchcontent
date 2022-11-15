include(FetchContent)

message(STATUS "get yaml-cpp ...")

FetchContent_Declare(
  yaml-cpp
  URL  https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-0.7.0.tar.gz
)

FetchContent_GetProperties(yaml-cpp)
if(NOT yaml-cpp_POPULATED)
  FetchContent_Populate(yaml-cpp)

  set(BUILD_TESTING OFF CACHE BOOL "")
  set(YAML_CPP_BUILD_TESTS OFF CACHE BOOL "")
  set(YAML_CPP_BUILD_TOOLS OFF CACHE BOOL "")
  set(YAML_CPP_INSTALL OFF CACHE BOOL "")

  add_subdirectory(${yaml-cpp_SOURCE_DIR} ${yaml-cpp_BINARY_DIR})
endif()

# import targets：
# yaml-cpp::yaml-cpp
