include(FetchContent)

message(STATUS "get snappy ...")

FetchContent_Declare(
  snappy
  URL https://github.com/google/snappy/archive/1.1.10.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(snappy)
if(NOT snappy_POPULATED)
  set(SNAPPY_BUILD_TESTS
      OFF
      CACHE BOOL "")
  set(SNAPPY_BUILD_BENCHMARKS
      OFF
      CACHE BOOL "")
  set(SNAPPY_INSTALL
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(snappy)

  add_library(snappy::snappy ALIAS snappy)
endif()

# import targets:
# snappy::snappy
