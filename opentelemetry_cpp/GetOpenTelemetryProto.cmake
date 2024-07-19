include(FetchContent)

message(STATUS "get opentelemetry_proto ...")

FetchContent_Declare(
  opentelemetry_proto
  URL https://github.com/open-telemetry/opentelemetry-proto/archive/v1.3.2.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(opentelemetry_proto)
if(NOT opentelemetry_proto_POPULATED)
  FetchContent_Populate(opentelemetry_proto)
endif()
