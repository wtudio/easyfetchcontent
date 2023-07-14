cmake_minimum_required(VERSION 3.26)

set(PRJ_NAME "TestGTest")

project(${PRJ_NAME})
message(STATUS "start cmake ${PRJ_NAME} ...")

# enable c++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(GetGTest)

# define src files
file(GLOB srcs ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
file(GLOB test_files ${CMAKE_CURRENT_SOURCE_DIR}/*_test.cpp)
list(REMOVE_ITEM srcs ${test_files})

# add library
add_library(${PRJ_NAME})

# set src files
target_sources(${PRJ_NAME} PRIVATE ${srcs})

# set head include path
target_include_directories(
  ${PRJ_NAME}
  PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# add library_test target for library
add_gtest_target(TEST_TARGET ${PRJ_NAME} TEST_SRC ${test_files})
