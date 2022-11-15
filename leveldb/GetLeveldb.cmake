include(FetchContent)

message(STATUS "get leveldb ...")

FetchContent_Declare(
  leveldb
  URL  https://github.com/google/leveldb/archive/1.23.tar.gz
)

FetchContent_GetProperties(leveldb)
if(NOT leveldb_POPULATED)
  FetchContent_Populate(leveldb)

  set(LEVELDB_BUILD_TESTS OFF CACHE BOOL "")
  set(LEVELDB_BUILD_BENCHMARKS OFF CACHE BOOL "")
  set(LEVELDB_INSTALL OFF CACHE BOOL "")

  add_subdirectory(${leveldb_SOURCE_DIR} ${leveldb_BINARY_DIR})

  add_library(leveldb::leveldb ALIAS leveldb)
endif()

# import targets：
# leveldb::leveldb
# leveldb::leveldbutil
