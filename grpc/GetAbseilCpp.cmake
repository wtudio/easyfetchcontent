include(FetchContent)

message(STATUS "get abseil-cpp ...")

FetchContent_Declare(
  abseil-cpp
  URL https://github.com/abseil/abseil-cpp/archive/20230125.3.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  OVERRIDE_FIND_PACKAGE
)

FetchContent_GetProperties(abseil-cpp)
if(NOT abseil-cpp_POPULATED)
  set(ABSL_PROPAGATE_CXX_STD ON CACHE BOOL "")
  FetchContent_MakeAvailable(abseil-cpp)
endif()
