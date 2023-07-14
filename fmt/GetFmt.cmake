include(FetchContent)

message(STATUS "get fmt ...")

FetchContent_Declare(
  fmt
  URL https://github.com/fmtlib/fmt/archive/8.0.1.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(fmt)
if(NOT fmt_POPULATED)
  set(FMT_MASTER_PROJECT
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(fmt)
endif()

# import targets:
# fmt::fmt
