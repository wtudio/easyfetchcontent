include(FetchContent)

message(STATUS "get inja ...")

FetchContent_Declare(
  inja
  URL  https://github.com/pantor/inja/archive/v3.3.0.tar.gz
)

set(INJA_INSTALL OFF CACHE BOOL "")
set(INJA_EXPORT OFF CACHE BOOL "")
set(BUILD_TESTING OFF CACHE BOOL "")
set(INJA_BUILD_TESTS OFF CACHE BOOL "")
set(BUILD_BENCHMARK OFF CACHE BOOL "")

FetchContent_MakeAvailable(inja)

# import targets：
# pantor::inja
