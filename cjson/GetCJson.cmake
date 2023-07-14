include(FetchContent)

message(STATUS "get cjson ...")

FetchContent_Declare(
  cjson
  URL https://github.com/DaveGamble/cJSON/archive/b45f48e600671feade0b6bd65d1c69de7899f2be.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(cjson)
if(NOT cjson_POPULATED)
  set(ENABLE_CJSON_UTILS
      OFF
      CACHE BOOL "")
  set(ENABLE_CJSON_TEST
      OFF
      CACHE BOOL "")
  set(CJSON_BUILD_SHARED_LIBS
      OFF
      CACHE BOOL "")
  set(ENABLE_CJSON_UNINSTALL
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(cjson)
  target_include_directories(cjson PUBLIC $<BUILD_INTERFACE:${cjson_SOURCE_DIR}>)

  add_library(cjson::cjson ALIAS cjson)
endif()

# import targets:
# cjson::cjson
