include(FetchContent)

message(STATUS "get mujoco ...")

FetchContent_Declare(
  mujoco
  URL  https://github.com/deepmind/mujoco/archive/2.3.5.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

FetchContent_GetProperties(mujoco)
if(NOT mujoco_POPULATED)
  set(MUJOCO_BUILD_EXAMPLES OFF CACHE BOOL "")
  set(MUJOCO_BUILD_SIMULATE ON CACHE BOOL "")
  set(MUJOCO_BUILD_TESTS OFF CACHE BOOL "")
  set(MUJOCO_TEST_PYTHON_UTIL OFF CACHE BOOL "")

  FetchContent_MakeAvailable(mujoco)
endif()
