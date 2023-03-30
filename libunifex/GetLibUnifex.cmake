include(FetchContent)

message(STATUS "get libunifex ...")

FetchContent_Declare(
  libunifex
  URL  https://github.com/facebookexperimental/libunifex/archive/c359fd8e7d97d91359cf4a6c1dbef99b0b1767b6.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

FetchContent_GetProperties(libunifex)
if(NOT libunifex_POPULATED)
  FetchContent_MakeAvailable(libunifex)

  add_library(libunifex::unifex ALIAS unifex)
endif()

# import targets:
# libunifex::unifex
