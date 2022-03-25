include(FetchContent)

message(STATUS "get freeglut ...")

FetchContent_Declare(
  freeglut
  URL  https://github.com/FreeGLUTProject/freeglut/releases/download/v3.2.2/freeglut-3.2.2.tar.gz
)

set(FREEGLUT_BUILD_DEMOS OFF CACHE BOOL "")

if(BUILD_SHARED_LIBS)
  set(FREEGLUT_BUILD_SHARED_LIBS ON CACHE BOOL "")
  set(FREEGLUT_BUILD_STATIC_LIBS OFF CACHE BOOL "")
else()
  set(FREEGLUT_BUILD_SHARED_LIBS OFF CACHE BOOL "")
  set(FREEGLUT_BUILD_STATIC_LIBS ON CACHE BOOL "")
endif()

FetchContent_MakeAvailable(freeglut)

if(NOT TARGET freeglut::freeglut)
  if (TARGET freeglut_static)
    add_library(freeglut::freeglut ALIAS freeglut_static)
    target_include_directories(freeglut_static INTERFACE $<BUILD_INTERFACE:${freeglut_SOURCE_DIR}/include/GL>)
  elseif (TARGET freeglut)
    add_library(freeglut::freeglut ALIAS freeglut)
    target_include_directories(freeglut INTERFACE $<BUILD_INTERFACE:${freeglut_SOURCE_DIR}/include/GL>)
  endif ()
endif ()

# import targets：
# freeglut::freeglut
