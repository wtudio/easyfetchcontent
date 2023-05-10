include(FetchContent)

message(STATUS "get re2 ...")

FetchContent_Declare(
  re2
  URL https://github.com/google/re2/archive/2023-03-01.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  OVERRIDE_FIND_PACKAGE
)

FetchContent_GetProperties(re2)
if(NOT re2_POPULATED)
  set(RE2_BUILD_TESTING OFF CACHE BOOL "")

  FetchContent_MakeAvailable(re2)
endif()
