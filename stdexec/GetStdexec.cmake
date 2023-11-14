include(FetchContent)

message(STATUS "get stdexec ...")

FetchContent_Declare(
  stdexec
  URL https://github.com/NVIDIA/stdexec/archive/nvhpc-23.09.rc4.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(stdexec)
if(NOT stdexec_POPULATED)

  set(STDEXEC_ENABLE_IO_URING_TESTS
      OFF
      CACHE BOOL "")

  set(STDEXEC_BUILD_EXAMPLES
      OFF
      CACHE BOOL "")

  set(STDEXEC_BUILD_TESTS
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(stdexec)
endif()

# import targets:
# STDEXEC::stdexec
# STDEXEC::nvexec
# STDEXEC::tbbexec
