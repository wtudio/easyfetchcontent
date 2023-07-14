include(FetchContent)

message(STATUS "get tinyxml2 ...")

FetchContent_Declare(
  tinyxml2
  URL https://github.com/leethomason/tinyxml2/archive/9.0.0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(tinyxml2)
if(NOT tinyxml2_POPULATED)
  set(BUILD_TESTING
      OFF
      CACHE BOOL "")
  set(tinyxml2_BUILD_TESTING
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(tinyxml2)
endif()

# import targets:
# tinyxml2::tinyxml2
