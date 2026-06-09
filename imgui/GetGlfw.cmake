include(FetchContent)

message(STATUS "get glfw ...")

FetchContent_Declare(
  glfw
  URL https://github.com/glfw/glfw/archive/3.4.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(glfw)
if(NOT glfw_POPULATED)
  set(GLFW_BUILD_DOCS
      OFF
      CACHE BOOL "")
  set(GLFW_BUILD_TESTS
      OFF
      CACHE BOOL "")
  set(GLFW_BUILD_EXAMPLES
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(glfw)

  add_library(glfw::glfw ALIAS glfw)
endif()

# import targets:
# glfw::glfw
