cmake_minimum_required(VERSION 3.20)

set(PRJ_NAME "TestProtobuf")

project(${PRJ_NAME} VERSION 0.1.0 LANGUAGES C CXX)
message(STATUS "start cmake ${PRJ_NAME} ...")

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(GetProtoBuf)

# add gencode target for path
add_protobuf_gencode_for_path_target(
  TARGET_NAME testgencode
  PROTO_PATH ${CMAKE_CURRENT_SOURCE_DIR}/protos
  GENCODE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/gen
)
add_library(testgencode::testgencode ALIAS testgencode)

#[[
# add gencode target for one file
add_protobuf_gencode_for_one_file_target(
  TARGET_NAME testgencode
  PROTO_FILE ${CMAKE_CURRENT_SOURCE_DIR}/protos/test.proto
  GENCODE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/gen
)
add_library(testgencode::testgencode ALIAS testgencode)
]]

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
  protobuf::libprotobuf
  testgencode::testgencode
)

# set build definitions(if any)
# target_compile_definitions(${PRJ_NAME} PRIVATE xxx)

# set misc
set_property(TARGET ${PRJ_NAME} PROPERTY UNITY_BUILD ON)
