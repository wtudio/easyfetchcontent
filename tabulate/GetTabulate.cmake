include(FetchContent)

message(STATUS "get tabulate ...")

FetchContent_Declare(
  tabulate
  URL https://github.com/p-ranav/tabulate/archive/v1.5.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(tabulate)
if(NOT tabulate_POPULATED)
  set(USE_CPP17
      ON
      CACHE BOOL "")

  FetchContent_MakeAvailable(tabulate)
endif()

# import targets:
# tabulate::tabulate
