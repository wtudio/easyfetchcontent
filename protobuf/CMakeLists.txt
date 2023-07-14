cmake_minimum_required(VERSION 3.26)

set(PRJ_NAME "TestProtobuf")

project(${PRJ_NAME})
message(STATUS "start cmake ${PRJ_NAME} ...")

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(GetProtoBuf)
include(ProtobufGenCode)

# add gencode target for path
add_protobuf_gencode_target_for_proto_path(
  TARGET_NAME testgencode
  PROTO_PATH ${CMAKE_CURRENT_SOURCE_DIR}/protos
  GENCODE_PATH ${CMAKE_CURRENT_BINARY_DIR})
add_library(testgencode::testgencode ALIAS testgencode)

# define src files
file(GLOB srcs ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

# add target
add_executable(${PRJ_NAME})

# set src files
target_sources(${PRJ_NAME} PRIVATE ${srcs})

# set head include path
target_include_directories(
  ${PRJ_NAME}
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# set link target
target_link_libraries(
  ${PRJ_NAME}
  PRIVATE protobuf::libprotobuf
          testgencode::testgencode)
