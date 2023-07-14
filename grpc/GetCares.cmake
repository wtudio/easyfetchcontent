include(FetchContent)

message(STATUS "get c-ares ...")

FetchContent_Declare(
  c-ares
  URL https://github.com/c-ares/c-ares/archive/cares-1_14_0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  OVERRIDE_FIND_PACKAGE)

FetchContent_GetProperties(c-ares)
if(NOT c-ares_POPULATED)
  FetchContent_MakeAvailable(c-ares)
endif()
