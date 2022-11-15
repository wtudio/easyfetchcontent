include(FetchContent)

message(STATUS "get libevent ...")

FetchContent_Declare(
  libevent
  URL  https://github.com/libevent/libevent/archive/release-2.1.12-stable.tar.gz
)

FetchContent_GetProperties(libevent)
if(NOT libevent_POPULATED)
  FetchContent_Populate(libevent)

  set(EVENT__DISABLE_OPENSSL ON CACHE BOOL "")
  set(EVENT__DISABLE_DEBUG_MODE ON CACHE BOOL "")
  set(EVENT__DISABLE_TESTS ON CACHE BOOL "")
  set(EVENT__DISABLE_BENCHMARK ON CACHE BOOL "")
  set(EVENT__DISABLE_REGRESS ON CACHE BOOL "")
  set(EVENT__DISABLE_SAMPLES ON CACHE BOOL "")

  if(BUILD_SHARED_LIBS)
    set(EVENT__LIBRARY_TYPE SHARED CACHE STRING "")
  else()
    set(EVENT__LIBRARY_TYPE STATIC CACHE STRING "")
  endif()

  add_subdirectory(${libevent_SOURCE_DIR} ${libevent_BINARY_DIR})

  add_library(libevent::event_core ALIAS event_core)
  add_library(libevent::event_extra ALIAS event_extra)
  add_library(libevent::event ALIAS event)
endif()

# import targets：
# libevent::event_core
# libevent::event_extra
# libevent::event
