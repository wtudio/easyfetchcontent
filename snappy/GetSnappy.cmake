include(FetchContent)

message(STATUS "get snappy ...")

FetchContent_Declare(
  snappy
  URL  https://github.com/google/snappy/archive/1.1.9.tar.gz
)

set(SNAPPY_BUILD_TESTS OFF CACHE BOOL "")
set(SNAPPY_BUILD_BENCHMARKS OFF CACHE BOOL "")
set(SNAPPY_INSTALL OFF CACHE BOOL "")

FetchContent_MakeAvailable(snappy)

add_library(snappy::snappy ALIAS snappy)

# import targets：
# snappy::snappy
