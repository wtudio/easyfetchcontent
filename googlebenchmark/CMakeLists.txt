cmake_minimum_required(VERSION 3.26)

set(PRJ_NAME "TestGoogleBenchmark")

project(${PRJ_NAME})
message(STATUS "start cmake ${PRJ_NAME} ...")

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(GetGoogleBenchmark)

# define src files
file(GLOB srcs ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
file(GLOB benchmark_files ${CMAKE_CURRENT_SOURCE_DIR}/*_benchmark.cpp)
list(REMOVE_ITEM srcs ${benchmark_files})

# add library
add_library(${PRJ_NAME})

# set src files
target_sources(${PRJ_NAME} PRIVATE ${srcs})

# set head include path
target_include_directories(
  ${PRJ_NAME}
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# add library_benchmark target for library
add_benchmark_target(BENCH_TARGET ${PRJ_NAME} BENCH_SRC ${benchmark_files})
