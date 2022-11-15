include(FetchContent)

message(STATUS "get taskflow ...")

FetchContent_Declare(
  taskflow
  URL  https://github.com/taskflow/taskflow/archive/v3.3.0.tar.gz
)

FetchContent_GetProperties(taskflow)
if(NOT taskflow_POPULATED)
  FetchContent_Populate(taskflow)

  set(TF_BUILD_TESTS OFF CACHE BOOL "")
  set(TF_BUILD_EXAMPLES OFF CACHE BOOL "")

  add_subdirectory(${taskflow_SOURCE_DIR} ${taskflow_BINARY_DIR})

  add_library(taskflow::Taskflow ALIAS Taskflow)
endif()

# import targets：
# taskflow::Taskflow
