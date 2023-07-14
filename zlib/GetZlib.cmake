include(FetchContent)

message(STATUS "get zlib ...")

FetchContent_Declare(
  zlib
  URL https://github.com/madler/zlib/archive/v1.2.13.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(zlib)
if(NOT zlib_POPULATED)
  FetchContent_MakeAvailable(zlib)
endif()

if(NOT TARGET zlib::zlibstati)
  add_library(zlib::zlibstatic ALIAS zlibstatic)
endif()

if(NOT TARGET zlib::zlib)
  add_library(zlib::zlib ALIAS zlib)
endif()

# import targets:
# zlib::zlibstatic
# zlib::zlib
