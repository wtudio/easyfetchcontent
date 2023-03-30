include(FetchContent)

message(STATUS "get hiredis ...")

FetchContent_Declare(
  hiredis
  URL  https://github.com/redis/hiredis/archive/v1.0.2.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

FetchContent_GetProperties(hiredis)
if(NOT hiredis_POPULATED)
  set(DISABLE_TESTS ON CACHE BOOL "")

  FetchContent_MakeAvailable(hiredis)

  add_library(hiredis::hiredis ALIAS hiredis)
endif()

# import targets:
# hiredis::hiredis
