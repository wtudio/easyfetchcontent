include(FetchContent)

message(STATUS "get spdlog ...")

FetchContent_Declare(
  spdlog
  URL  https://github.com/gabime/spdlog/archive/v1.9.2.tar.gz
)

FetchContent_GetProperties(spdlog)
if(NOT spdlog_POPULATED)
  FetchContent_Populate(spdlog)

  set(SPDLOG_FMT_EXTERNAL ON CACHE BOOL "")

  add_subdirectory(${spdlog_SOURCE_DIR} ${spdlog_BINARY_DIR})
endif()

# import targets：
# spdlog::spdlog
# spdlog::spdlog_header_only
