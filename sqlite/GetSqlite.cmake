include(FetchContent)

message(STATUS "get sqlite ...")

# sqlite版本记录：https://www.sqlite.org/chronology.html
FetchContent_Declare(
  sqlite
  URL  https://sqlite.org/2021/sqlite-amalgamation-3370000.zip
)

FetchContent_GetProperties(sqlite)
if(NOT sqlite_POPULATED)
  FetchContent_Populate(sqlite)
endif()

# sqlite exe
add_executable(sqlite)
add_executable(sqlite::sqlite ALIAS sqlite)

target_sources(sqlite PRIVATE ${sqlite_SOURCE_DIR}/sqlite3.c ${sqlite_SOURCE_DIR}/shell.c)
target_include_directories(sqlite PRIVATE ${sqlite_SOURCE_DIR})
if(UNIX)
  target_link_libraries(sqlite PRIVATE pthread dl)
endif()

# sqlite lib
add_library(libsqlite)
add_library(sqlite::libsqlite ALIAS libsqlite)

target_sources(libsqlite PRIVATE ${sqlite_SOURCE_DIR}/sqlite3.c)
target_include_directories(libsqlite PUBLIC ${sqlite_SOURCE_DIR})
if(UNIX)
  target_link_libraries(libsqlite PUBLIC pthread dl)
endif()

# import targets：
# sqlite::sqlite
# sqlite::libsqlite
