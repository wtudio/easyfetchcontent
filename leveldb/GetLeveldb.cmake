include(FetchContent)

message(STATUS "get leveldb ...")

FetchContent_Declare(
  leveldb
  URL  https://github.com/google/leveldb/archive/1.23.tar.gz
)

set(LEVELDB_BUILD_TESTS OFF CACHE BOOL "")
set(LEVELDB_BUILD_BENCHMARKS OFF CACHE BOOL "")
set(LEVELDB_INSTALL OFF CACHE BOOL "")

FetchContent_MakeAvailable(leveldb)

add_library(leveldb::leveldb ALIAS leveldb)

# import targets：
# leveldb::leveldb
# leveldb::leveldbutil
