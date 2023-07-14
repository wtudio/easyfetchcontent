include(FetchContent)

message(STATUS "get grpc ...")

FetchContent_Declare(
  grpc
  URL https://github.com/grpc/grpc/archive/v1.54.1.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  OVERRIDE_FIND_PACKAGE)

FetchContent_GetProperties(grpc)
if(NOT grpc_POPULATED)
  set(gRPC_BUILD_TESTS
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_CODEGEN
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_CSHARP_EXT
      OFF
      CACHE BOOL "")
  set(gRPC_BACKWARDS_COMPATIBILITY_MODE
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_GRPC_CPP_PLUGIN
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_GRPC_CSHARP_PLUGIN
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_GRPC_NODE_PLUGIN
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_GRPC_OBJECTIVE_C_PLUGIN
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_GRPC_PHP_PLUGIN
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_GRPC_PYTHON_PLUGIN
      OFF
      CACHE BOOL "")
  set(gRPC_BUILD_GRPC_RUBY_PLUGIN
      OFF
      CACHE BOOL "")

  set(gRPC_ABSL_PROVIDER
      "package"
      CACHE STRING "Provider of absl library")
  set(gRPC_CARES_PROVIDER
      "package"
      CACHE STRING "Provider of c-ares library")
  set(gRPC_ZLIB_PROVIDER
      "package"
      CACHE STRING "Provider of zlib library")
  set(gRPC_PROTOBUF_PROVIDER
      "package"
      CACHE STRING "Provider of protobuf library")
  set(gRPC_RE2_PROVIDER
      "package"
      CACHE STRING "Provider of re2 library")
  # note: you need to install openssl locally first
  set(gRPC_SSL_PROVIDER
      "package"
      CACHE STRING "Provider of ssl library")

  include(GetAbseilCpp)
  include(GetCares)
  include(GetZlib)
  include(GetProtobuf)
  include(GetRe2)

  FetchContent_MakeAvailable(grpc)

  add_library(grpc::grpc ALIAS grpc)
endif()

# import targets:
# grpc::grpc
