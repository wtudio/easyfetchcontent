include(FetchContent)

message(STATUS "get freeglut ...")

FetchContent_Declare(
  freeglut
  URL  https://github.com/FreeGLUTProject/freeglut/releases/download/v3.2.2/freeglut-3.2.2.tar.gz
)

FetchContent_GetProperties(freeglut)
if(NOT freeglut_POPULATED)
  FetchContent_Populate(freeglut)

  set(FREEGLUT_BUILD_DEMOS OFF CACHE BOOL "")

  if(BUILD_SHARED_LIBS)
    set(FREEGLUT_BUILD_SHARED_LIBS ON CACHE BOOL "")
    set(FREEGLUT_BUILD_STATIC_LIBS OFF CACHE BOOL "")
  else()
    set(FREEGLUT_BUILD_SHARED_LIBS OFF CACHE BOOL "")
    set(FREEGLUT_BUILD_STATIC_LIBS ON CACHE BOOL "")
  endif()

  add_subdirectory(${freeglut_SOURCE_DIR} ${freeglut_BINARY_DIR})

  if(TARGET freeglut_static)
    add_library(freeglut::freeglut ALIAS freeglut_static)
    target_include_directories(freeglut_static INTERFACE $<BUILD_INTERFACE:${freeglut_SOURCE_DIR}/include/GL>)
  elseif(TARGET freeglut)
    add_library(freeglut::freeglut ALIAS freeglut)
    target_include_directories(freeglut INTERFACE $<BUILD_INTERFACE:${freeglut_SOURCE_DIR}/include/GL>)
  endif()
endif()

# import targets：
# freeglut::freeglut
