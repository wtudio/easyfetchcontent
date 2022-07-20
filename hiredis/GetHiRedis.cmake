include(FetchContent)

message(STATUS "get hiredis ...")

FetchContent_Declare(
  hiredis
  URL  https://github.com/redis/hiredis/archive/v1.0.2.tar.gz
)

set(DISABLE_TESTS ON CACHE BOOL "")

FetchContent_MakeAvailable(hiredis)

if(NOT TARGET hiredis::hiredis)
  add_library(hiredis::hiredis ALIAS hiredis)
endif()

# import targets：
# hiredis::hiredis
