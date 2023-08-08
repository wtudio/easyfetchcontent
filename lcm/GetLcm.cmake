include(FetchContent)

message(STATUS "get lcm ...")

FetchContent_Declare(
  lcm
  URL https://github.com/lcm-proj/lcm/archive/v1.5.0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(lcm)
if(NOT lcm_POPULATED)
  set(LCM_ENABLE_EXAMPLES
      OFF
      CACHE BOOL "")

  set(LCM_ENABLE_TESTS
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(lcm)

  add_library(lcm::lcm-coretypes ALIAS lcm-coretypes)
  add_library(lcm::lcm-static ALIAS lcm-static)
  add_library(lcm::lcm ALIAS lcm)
endif()

# import targets:
# lcm::lcm-coretypes
# lcm::lcm-static
# lcm::lcm
