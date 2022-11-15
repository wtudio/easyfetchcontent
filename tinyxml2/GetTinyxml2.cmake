include(FetchContent)

message(STATUS "get tinyxml2 ...")

FetchContent_Declare(
  tinyxml2
  URL  https://github.com/leethomason/tinyxml2/archive/9.0.0.tar.gz
)

FetchContent_GetProperties(tinyxml2)
if(NOT tinyxml2_POPULATED)
  FetchContent_Populate(tinyxml2)

  set(BUILD_TESTING OFF CACHE BOOL "")
  set(tinyxml2_BUILD_TESTING OFF CACHE BOOL "")

  add_subdirectory(${tinyxml2_SOURCE_DIR} ${tinyxml2_BINARY_DIR})
endif()

# import targets：
# tinyxml2::tinyxml2
