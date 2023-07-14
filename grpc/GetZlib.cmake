include(FetchContent)

message(STATUS "get zlib ...")

FetchContent_Declare(
  zlib
  URL https://github.com/madler/zlib/archive/v1.2.13.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  OVERRIDE_FIND_PACKAGE)

FetchContent_GetProperties(zlib)
if(NOT zlib_POPULATED)
  FetchContent_MakeAvailable(zlib)
endif()
