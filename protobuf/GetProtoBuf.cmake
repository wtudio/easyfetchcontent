include(FetchContent)

message(STATUS "get protobuf ...")

FetchContent_Declare(
  protobuf
  URL   https://github.com/protocolbuffers/protobuf/archive/v3.18.1.tar.gz
  SOURCE_SUBDIR  cmake
)

set(protobuf_BUILD_TESTS OFF CACHE BOOL "")
set(protobuf_WITH_ZLIB OFF CACHE BOOL "")

FetchContent_MakeAvailable(protobuf)

# import targets：
# protobuf::libprotobuf
# protobuf::libprotobuf-lite
# protobuf::libprotoc
# protobuf::protoc

# add target for protobuf gen code
function(add_protobuf_gencode_target)
  cmake_parse_arguments(ARG "" "TARGET_NAME" "PROTO_PATH;GENCODE_PATH;OPTIONS" ${ARGN})

  if(NOT EXISTS ${ARG_GENCODE_PATH})
    file(MAKE_DIRECTORY ${ARG_GENCODE_PATH})
  endif()

  set(GEN_SRCS)
  set(GEN_HDRS)

  File(GLOB_RECURSE PROTO_FILES ${ARG_PROTO_PATH}/*.proto)
  foreach(PROTO_FILE ${PROTO_FILES})
    STRING(REGEX REPLACE ".+/(.+)\\..*" "\\1" PROTO_FILE_NAME ${PROTO_FILE})
    set(GEN_SRC "${ARG_GENCODE_PATH}/${PROTO_FILE_NAME}.pb.cc")
    set(GEN_HDR "${ARG_GENCODE_PATH}/${PROTO_FILE_NAME}.pb.h")

    list(APPEND GEN_SRCS ${GEN_SRC})
    list(APPEND GEN_HDRS ${GEN_HDR})

    add_custom_command(
      OUTPUT ${GEN_SRC} ${GEN_HDR}
      COMMAND protobuf::protoc
      ARGS ${ARG_OPTIONS} --proto_path ${ARG_PROTO_PATH} --cpp_out ${ARG_GENCODE_PATH} ${PROTO_FILE}
      DEPENDS ${PROTO_FILE} protobuf::protoc
      COMMENT "Running cpp protocol buffer compiler on ${PROTO_FILE}. Custom options: ${ARG_OPTIONS}"
      VERBATIM
    )
  endforeach()

  add_library(${ARG_TARGET_NAME} INTERFACE)

  target_sources(${ARG_TARGET_NAME} PUBLIC ${GEN_SRCS})
  target_include_directories(${ARG_TARGET_NAME} INTERFACE ${ARG_GENCODE_PATH})
  set_property(TARGET ${ARG_TARGET_NAME} PROPERTY PUBLIC_HEADER ${GEN_HDRS})

endfunction()
