cmake_minimum_required(VERSION 3.26)

set(PRJ_NAME "TestOpenTelemetryCpp")

project(${PRJ_NAME})
message(STATUS "start cmake ${PRJ_NAME} ...")

# enable c++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(GetNlohmannJson)
include(GetProtoBuf)
include(GetOpenTelemetryProto)
include(GetOpenTelemetryCpp)

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
  PRIVATE opentelemetry-cpp::api
          opentelemetry-cpp::sdk
          opentelemetry-cpp::ext
          opentelemetry-cpp::version
          opentelemetry-cpp::common
          opentelemetry-cpp::trace
          opentelemetry-cpp::metrics
          opentelemetry-cpp::logs
          opentelemetry-cpp::ostream_span_exporter
          opentelemetry-cpp::ostream_metrics_exporter
          opentelemetry-cpp::ostream_log_record_exporter
          opentelemetry-cpp::otlp_recordable
          opentelemetry-cpp::otlp_http_client
          opentelemetry-cpp::otlp_http_exporter
          opentelemetry-cpp::otlp_http_log_record_exporter
          opentelemetry-cpp::otlp_http_metric_exporter
          opentelemetry-cpp::http_client_curl)
