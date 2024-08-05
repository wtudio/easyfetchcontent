include(FetchContent)

message(STATUS "Getting zeromq ...")

FetchContent_Declare(
  zeromq
  URL https://github.com/zeromq/libzmq/archive/v4.3.5.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP ON)

FetchContent_GetProperties(zeromq)
if(NOT zeromq_POPULATED)
  set(ZMQ_BUILD_TESTS
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(zeromq)

  if(TARGET libzmq-static)
    add_library(libzmq::libzmq-static ALIAS libzmq-static)
  endif()

  if(TARGET libzmq)
    add_library(libzmq::libzmq ALIAS libzmq)
  endif()
endif()
