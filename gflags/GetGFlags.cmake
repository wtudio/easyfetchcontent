include(FetchContent)

message(STATUS "get gflags ...")

FetchContent_Declare(
  gflags
  URL https://github.com/gflags/gflags/archive/v2.2.2.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

FetchContent_GetProperties(gflags)
if(NOT gflags_POPULATED)
  set(BUILD_TESTING OFF CACHE BOOL "")

  FetchContent_MakeAvailable(gflags)
endif()

# import targets:
# gflags::gflags
