include(FetchContent)

message(STATUS "get protobuf ...")

FetchContent_Declare(
  protobuf
  URL https://github.com/protocolbuffers/protobuf/archive/v3.21.12.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(protobuf)
if(NOT protobuf_POPULATED)
  set(protobuf_BUILD_TESTS
      OFF
      CACHE BOOL "")
  set(protobuf_WITH_ZLIB
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(protobuf)
endif()

# import targets:
# protobuf::libprotobuf
# protobuf::libprotobuf-lite
# protobuf::libprotoc
# protobuf::protoc
