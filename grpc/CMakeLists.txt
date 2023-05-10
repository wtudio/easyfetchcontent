cmake_minimum_required(VERSION 3.20)

set(PRJ_NAME "TestGrpc")

project(${PRJ_NAME} VERSION 0.1.0 LANGUAGES C CXX)
message(STATUS "start cmake ${PRJ_NAME} ...")

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(GetGrpc)

# define head files and src files
File(GLOB hdrs ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
File(GLOB srcs ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

# add target
add_executable(${PRJ_NAME})

# set src files
target_sources(${PRJ_NAME} PRIVATE ${srcs})

# set head include path
target_include_directories(${PRJ_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# set link target
target_link_libraries(${PRJ_NAME} PRIVATE
  grpc::grpc
)

# set build definitions(if any)
# target_compile_definitions(${PRJ_NAME} PRIVATE xxx)

# set misc
set_property(TARGET ${PRJ_NAME} PROPERTY UNITY_BUILD ON)
