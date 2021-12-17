cmake_minimum_required(VERSION 3.20)

set(PRJ_NAME "TestGoogleBenchmark")

project(${PRJ_NAME} VERSION 0.1.0 LANGUAGES C CXX)
message(STATUS "start cmake ${PRJ_NAME} ...")

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(GetGoogleBenchmark)

# define head files and src files
File(GLOB hdrs ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
File(GLOB srcs ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
File(GLOB benchmark_files ${CMAKE_CURRENT_SOURCE_DIR}/*_benchmark.cpp)
LIST(REMOVE_ITEM srcs ${benchmark_files})

# add library
add_library(${PRJ_NAME})

# set src files
target_sources(${PRJ_NAME} PRIVATE ${srcs})

# set head include path
target_include_directories(${PRJ_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# set misc
set_property(TARGET ${PRJ_NAME} PROPERTY UNITY_BUILD ON)

# add library_benchmark target for library
add_benchmark_target(BENCH_TARGET ${PRJ_NAME} BENCH_SRC ${benchmark_files})
