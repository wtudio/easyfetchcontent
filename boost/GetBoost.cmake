include(FetchContent)

message(STATUS "get boost ...")

FetchContent_Declare(
  Boost
  URL https://github.com/boostorg/boost/releases/download/boost-1.81.0/boost-1.81.0.tar.xz
  DOWNLOAD_EXTRACT_TIMESTAMP ON)

FetchContent_GetProperties(Boost)
if(NOT Boost_POPULATED)
  set(BOOST_INCLUDE_LIBRARIES asio)
  FetchContent_MakeAvailable(Boost)
endif()
