include(FetchContent)

message(STATUS "get lua ...")

FetchContent_Declare(
  lua
  URL https://github.com/lua/lua/archive/v5.4.3.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(lua)
if(NOT lua_POPULATED)
  FetchContent_Populate(lua)

  # lua exe
  add_executable(lua)
  add_executable(lua::lua ALIAS lua)

  file(GLOB lua_src ${lua_SOURCE_DIR}/*.c)
  list(REMOVE_ITEM lua_src ${lua_SOURCE_DIR}/onelua.c)

  target_sources(lua PRIVATE ${lua_src})
  target_include_directories(lua PRIVATE ${lua_SOURCE_DIR})
  if(UNIX)
    target_link_libraries(lua PRIVATE m)
  endif()

  # lua lib
  add_library(liblua)
  add_library(lua::liblua ALIAS liblua)

  file(GLOB lib_lua_src ${lua_SOURCE_DIR}/*.c)
  list(REMOVE_ITEM lib_lua_src ${lua_SOURCE_DIR}/lua.c ${lua_SOURCE_DIR}/onelua.c)

  target_sources(liblua PRIVATE ${lib_lua_src})
  target_include_directories(liblua PUBLIC ${lua_SOURCE_DIR})
  if(UNIX)
    target_link_libraries(liblua PRIVATE m)
  endif()

endif()

# import targets:
# lua::lua
# lua::liblua
