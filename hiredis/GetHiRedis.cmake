include(FetchContent)

message(STATUS "get hiredis ...")

FetchContent_Declare(
  hiredis
  URL  https://github.com/redis/hiredis/archive/v1.0.2.tar.gz
)

FetchContent_GetProperties(hiredis)
if(NOT hiredis_POPULATED)
  FetchContent_Populate(hiredis)

  set(DISABLE_TESTS ON CACHE BOOL "")

  add_subdirectory(${hiredis_SOURCE_DIR} ${hiredis_BINARY_DIR})

  add_library(hiredis::hiredis ALIAS hiredis)
endif()

# import targets：
# hiredis::hiredis
