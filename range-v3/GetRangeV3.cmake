include(FetchContent)

message(STATUS "get range-v3 ...")

FetchContent_Declare(
  range-v3
  URL  https://github.com/ericniebler/range-v3/archive/0.11.0.tar.gz
)

FetchContent_MakeAvailable(range-v3)

# import targets：
# range-v3::range-v3
