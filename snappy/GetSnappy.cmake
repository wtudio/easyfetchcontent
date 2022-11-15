include(FetchContent)

message(STATUS "get snappy ...")

FetchContent_Declare(
  snappy
  URL  https://github.com/google/snappy/archive/1.1.9.tar.gz
)

FetchContent_GetProperties(snappy)
if(NOT snappy_POPULATED)
  FetchContent_Populate(snappy)

  set(SNAPPY_BUILD_TESTS OFF CACHE BOOL "")
  set(SNAPPY_BUILD_BENCHMARKS OFF CACHE BOOL "")
  set(SNAPPY_INSTALL OFF CACHE BOOL "")

  add_subdirectory(${snappy_SOURCE_DIR} ${snappy_BINARY_DIR})

  add_library(snappy::snappy ALIAS snappy)
endif()

# import targets：
# snappy::snappy
