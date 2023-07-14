include(FetchContent)

message(STATUS "get taskflow ...")

FetchContent_Declare(
  taskflow
  URL https://github.com/taskflow/taskflow/archive/v3.3.0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(taskflow)
if(NOT taskflow_POPULATED)
  set(TF_BUILD_TESTS
      OFF
      CACHE BOOL "")
  set(TF_BUILD_EXAMPLES
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(taskflow)

  add_library(taskflow::Taskflow ALIAS Taskflow)
endif()

# import targets:
# taskflow::Taskflow
