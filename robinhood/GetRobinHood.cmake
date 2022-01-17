include(FetchContent)

message(STATUS "get robin_hood ...")

FetchContent_Declare(
  robin_hood
  URL  https://github.com/martinus/robin-hood-hashing/archive/3.11.5.tar.gz
)

FetchContent_MakeAvailable(robin_hood)

# import targets：
# robin_hood::robin_hood
