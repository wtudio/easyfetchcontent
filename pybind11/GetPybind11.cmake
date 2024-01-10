include(FetchContent)

message(STATUS "get pybind11 ...")

FetchContent_Declare(
  pybind11
  URL https://github.com/pybind/pybind11/archive/v2.11.1.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(pybind11)
if(NOT pybind11_POPULATED)
  FetchContent_MakeAvailable(pybind11)
endif()
