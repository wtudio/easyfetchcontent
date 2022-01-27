include(FetchContent)

message(STATUS "get fmt ...")

FetchContent_Declare(
  fmt
  URL  https://github.com/fmtlib/fmt/archive/8.0.1.tar.gz
)

set(FMT_MASTER_PROJECT OFF CACHE BOOL "")

FetchContent_MakeAvailable(fmt)

# import targets：
# fmt::fmt
