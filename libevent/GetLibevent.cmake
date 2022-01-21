include(FetchContent)

message(STATUS "get libevent ...")

FetchContent_Declare(
  libevent
  URL  https://github.com/libevent/libevent/archive/release-2.1.12-stable.tar.gz
)

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

FetchContent_MakeAvailable(libevent)

if(NOT TARGET libevent::event_core)
  add_library(libevent::event_core ALIAS event_core)
endif ()

if(NOT TARGET libevent::event_extra)
  add_library(libevent::event_extra ALIAS event_extra)
endif ()

if(NOT TARGET libevent::event)
  add_library(libevent::event ALIAS event)
endif ()

# import targets：
# libevent::event_core
# libevent::event_extra
# libevent::event
