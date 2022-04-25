include(FetchContent)

message(STATUS "get libuv ...")

FetchContent_Declare(
  libuv
  URL  https://github.com/libuv/libuv/archive/v1.44.1.tar.gz
)

set(BUILD_TESTING OFF CACHE BOOL "")
set(LIBUV_BUILD_TESTS OFF CACHE BOOL "")
set(LIBUV_BUILD_BENCH OFF CACHE BOOL "")

FetchContent_MakeAvailable(libuv)

if(NOT TARGET libuv::libuv)
  if(BUILD_SHARED_LIBS)
    if(TARGET uv)
      add_library(libuv::libuv ALIAS uv)
    endif()
  else()
    if(TARGET uv)
      add_library(libuv::libuv ALIAS uv_a)
    endif()
  endif()
endif()

# import targets：
# libuv::libuv
