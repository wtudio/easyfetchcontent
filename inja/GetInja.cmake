include(FetchContent)

message(STATUS "get inja ...")

FetchContent_Declare(
  inja
  URL  https://github.com/pantor/inja/archive/v3.3.0.tar.gz
)

FetchContent_GetProperties(inja)
if(NOT inja_POPULATED)
  FetchContent_Populate(inja)

  set(INJA_INSTALL OFF CACHE BOOL "")
  set(INJA_EXPORT OFF CACHE BOOL "")
  set(BUILD_TESTING OFF CACHE BOOL "")
  set(INJA_BUILD_TESTS OFF CACHE BOOL "")
  set(BUILD_BENCHMARK OFF CACHE BOOL "")

  add_subdirectory(${inja_SOURCE_DIR} ${inja_BINARY_DIR})
endif()

# import targets：
# pantor::inja
