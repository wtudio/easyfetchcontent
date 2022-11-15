include(FetchContent)

message(STATUS "get gflags ...")

FetchContent_Declare(
  gflags
  URL https://github.com/gflags/gflags/archive/v2.2.2.tar.gz
)

FetchContent_GetProperties(gflags)
if(NOT gflags_POPULATED)
  FetchContent_Populate(gflags)

  set(BUILD_TESTING OFF CACHE BOOL "")

  add_subdirectory(${gflags_SOURCE_DIR} ${gflags_BINARY_DIR})
endif()

# import targets：
# gflags::gflags
