include(FetchContent)

message(STATUS "get raylib ...")

FetchContent_Declare(
  raylib
  URL https://github.com/raysan5/raylib/archive/5.5.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(raylib)
if(NOT raylib_POPULATED)
  FetchContent_MakeAvailable(raylib)

  add_library(raylib::raylib ALIAS raylib)
endif()

# import targets:
# raylib::raylib
