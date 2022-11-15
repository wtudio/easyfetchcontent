include(FetchContent)

message(STATUS "get fmt ...")

FetchContent_Declare(
  fmt
  URL  https://github.com/fmtlib/fmt/archive/8.0.1.tar.gz
)

FetchContent_GetProperties(fmt)
if(NOT fmt_POPULATED)
  FetchContent_Populate(fmt)

  set(FMT_MASTER_PROJECT OFF CACHE BOOL "")

  add_subdirectory(${fmt_SOURCE_DIR} ${fmt_BINARY_DIR})
endif()

# import targets：
# fmt::fmt
