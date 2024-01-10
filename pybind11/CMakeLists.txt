cmake_minimum_required(VERSION 3.26)

set(PRJ_NAME "TestPybind11")

project(${PRJ_NAME})
message(STATUS "start cmake ${PRJ_NAME} ...")

# enable c++20
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
find_package(Python3 REQUIRED COMPONENTS Interpreter Development)
include(GetPybind11)

# define src files
file(GLOB srcs ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

# add target
pybind11_add_module(${PRJ_NAME} SHARED)

# set src files
target_sources(${PRJ_NAME} PRIVATE ${srcs})

# set head include path
target_include_directories(
  ${PRJ_NAME}
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
