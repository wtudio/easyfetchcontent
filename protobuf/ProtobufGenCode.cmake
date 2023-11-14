# add target for protobuf gen code target for proto path
function(add_protobuf_gencode_target_for_proto_path)
  cmake_parse_arguments(ARG "" "TARGET_NAME" "PROTO_PATH;GENCODE_PATH;DEP_PROTO_TARGETS;OPTIONS" ${ARGN})

  if(NOT EXISTS ${ARG_GENCODE_PATH})
    file(MAKE_DIRECTORY ${ARG_GENCODE_PATH})
  endif()

  set(ALL_DEP_PROTO_TARGETS ${ARG_DEP_PROTO_TARGETS})
  foreach(CUR_DEP_PROTO_TARGET ${ARG_DEP_PROTO_TARGETS})
    get_target_property(SECONDARY_DEP_PROTO_TARGET ${CUR_DEP_PROTO_TARGET} DEP_PROTO_TARGETS)
    list(APPEND ALL_DEP_PROTO_TARGETS ${SECONDARY_DEP_PROTO_TARGET})
  endforeach()
  list(REMOVE_DUPLICATES ALL_DEP_PROTO_TARGETS)

  set(PROTOC_EXTERNAL_PROTO_PATH_ARGS)
  foreach(CUR_DEP_PROTO_TARGET ${ALL_DEP_PROTO_TARGETS})
    get_target_property(DEP_PROTO_TARGET_PROTO_PATH ${CUR_DEP_PROTO_TARGET} PROTO_PATH)
    list(APPEND PROTOC_EXTERNAL_PROTO_PATH_ARGS "--proto_path=${DEP_PROTO_TARGET_PROTO_PATH}")
  endforeach()
  list(REMOVE_DUPLICATES PROTOC_EXTERNAL_PROTO_PATH_ARGS)

  set(GEN_SRCS)
  set(GEN_HDRS)

  file(GLOB_RECURSE PROTO_FILES ${ARG_PROTO_PATH}/*.proto)
  foreach(PROTO_FILE ${PROTO_FILES})
    string(REGEX REPLACE ".+/(.+)\\..*" "\\1" PROTO_FILE_NAME ${PROTO_FILE})
    set(GEN_SRC "${ARG_GENCODE_PATH}/${PROTO_FILE_NAME}.pb.cc")
    set(GEN_HDR "${ARG_GENCODE_PATH}/${PROTO_FILE_NAME}.pb.h")

    list(APPEND GEN_SRCS ${GEN_SRC})
    list(APPEND GEN_HDRS ${GEN_HDR})

    add_custom_command(
      OUTPUT ${GEN_SRC} ${GEN_HDR}
      COMMAND protobuf::protoc ARGS ${ARG_OPTIONS} --proto_path=${ARG_PROTO_PATH} ${PROTOC_EXTERNAL_PROTO_PATH_ARGS} --cpp_out=${ARG_GENCODE_PATH}
              ${PROTO_FILE}
      DEPENDS ${PROTO_FILE} protobuf::protoc
      COMMENT
        "Running protoc, args: ${ARG_OPTIONS} --proto_path=${ARG_PROTO_PATH} ${PROTOC_EXTERNAL_PROTO_PATH_ARGS} --cpp_out=${ARG_GENCODE_PATH} ${PROTO_FILE}"
      VERBATIM)
  endforeach()

  add_library(${ARG_TARGET_NAME} STATIC)

  target_sources(${ARG_TARGET_NAME} PRIVATE ${GEN_SRCS})
  target_sources(${ARG_TARGET_NAME} PUBLIC FILE_SET HEADERS BASE_DIRS ${ARG_GENCODE_PATH} FILES ${GEN_HDRS})
  target_include_directories(${ARG_TARGET_NAME} PUBLIC $<BUILD_INTERFACE:${ARG_GENCODE_PATH}> $<INSTALL_INTERFACE:include/${ARG_TARGET_NAME}>)

  target_link_libraries(${ARG_TARGET_NAME} PUBLIC protobuf::libprotobuf ${ALL_DEP_PROTO_TARGETS})

  set_target_properties(${ARG_TARGET_NAME} PROPERTIES PROTO_PATH ${ARG_PROTO_PATH})
  set_target_properties(${ARG_TARGET_NAME} PROPERTIES DEP_PROTO_TARGETS "${ALL_DEP_PROTO_TARGETS}")

endfunction()

# add target for protobuf gen code target for one file
function(add_protobuf_gencode_target_for_one_proto_file)
  cmake_parse_arguments(ARG "" "TARGET_NAME" "PROTO_FILE;GENCODE_PATH;DEP_PROTO_TARGETS;OPTIONS" ${ARGN})

  if(NOT EXISTS ${ARG_GENCODE_PATH})
    file(MAKE_DIRECTORY ${ARG_GENCODE_PATH})
  endif()

  set(ALL_DEP_PROTO_TARGETS ${ARG_DEP_PROTO_TARGETS})
  foreach(CUR_DEP_PROTO_TARGET ${ARG_DEP_PROTO_TARGETS})
    get_target_property(SECONDARY_DEP_PROTO_TARGET ${CUR_DEP_PROTO_TARGET} DEP_PROTO_TARGETS)
    list(APPEND ALL_DEP_PROTO_TARGETS ${SECONDARY_DEP_PROTO_TARGET})
  endforeach()
  list(REMOVE_DUPLICATES ALL_DEP_PROTO_TARGETS)

  set(PROTOC_EXTERNAL_PROTO_PATH_ARGS)
  foreach(CUR_DEP_PROTO_TARGET ${ALL_DEP_PROTO_TARGETS})
    get_target_property(DEP_PROTO_TARGET_PROTO_PATH ${CUR_DEP_PROTO_TARGET} PROTO_PATH)
    list(APPEND PROTOC_EXTERNAL_PROTO_PATH_ARGS "--proto_path=${DEP_PROTO_TARGET_PROTO_PATH}")
  endforeach()
  list(REMOVE_DUPLICATES PROTOC_EXTERNAL_PROTO_PATH_ARGS)

  string(REGEX REPLACE ".+/(.+)\\..*" "\\1" PROTO_FILE_NAME ${ARG_PROTO_FILE})
  string(REGEX REPLACE "(.+)/(.+)\\..*" "\\1" PROTO_PATH ${ARG_PROTO_FILE})
  set(GEN_SRC "${ARG_GENCODE_PATH}/${PROTO_FILE_NAME}.pb.cc")
  set(GEN_HDR "${ARG_GENCODE_PATH}/${PROTO_FILE_NAME}.pb.h")

  add_custom_command(
    OUTPUT ${GEN_SRC} ${GEN_HDR}
    COMMAND protobuf::protoc ARGS ${ARG_OPTIONS} --proto_path=${PROTO_PATH} ${PROTOC_EXTERNAL_PROTO_PATH_ARGS} --cpp_out=${ARG_GENCODE_PATH}
            ${ARG_PROTO_FILE}
    DEPENDS ${ARG_PROTO_FILE} protobuf::protoc
    COMMENT
      "Running protoc, args: ${ARG_OPTIONS} --proto_path=${PROTO_PATH} ${PROTOC_EXTERNAL_PROTO_PATH_ARGS} --cpp_out=${ARG_GENCODE_PATH} ${ARG_PROTO_FILE}"
    VERBATIM)

  add_library(${ARG_TARGET_NAME} STATIC)

  target_sources(${ARG_TARGET_NAME} PRIVATE ${GEN_SRC})
  target_sources(${ARG_TARGET_NAME} PUBLIC FILE_SET HEADERS BASE_DIRS ${ARG_GENCODE_PATH} FILES ${GEN_HDR})
  target_include_directories(${ARG_TARGET_NAME} PUBLIC $<BUILD_INTERFACE:${ARG_GENCODE_PATH}> $<INSTALL_INTERFACE:include/${ARG_TARGET_NAME}>)

  target_link_libraries(${ARG_TARGET_NAME} PUBLIC protobuf::libprotobuf ${ALL_DEP_PROTO_TARGETS})

  set_target_properties(${ARG_TARGET_NAME} PROPERTIES PROTO_PATH ${PROTO_PATH})
  set_target_properties(${ARG_TARGET_NAME} PROPERTIES DEP_PROTO_TARGETS "${ALL_DEP_PROTO_TARGETS}")

endfunction()