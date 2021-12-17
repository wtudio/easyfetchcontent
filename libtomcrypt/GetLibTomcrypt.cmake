include(FetchContent)

message(STATUS "get libtomcrypt ...")

FetchContent_Declare(
  libtomcrypt
  URL  https://github.com/libtom/libtomcrypt/archive/v1.18.2.tar.gz
)

FetchContent_GetProperties(libtomcrypt)
if(NOT libtomcrypt_POPULATED)
  FetchContent_Populate(libtomcrypt)
endif()

File(GLOB_RECURSE libtomcrypt_src ${libtomcrypt_SOURCE_DIR}/src/*.c)

add_library(libtomcrypt)
add_library(libtomcrypt::libtomcrypt ALIAS libtomcrypt)

target_sources(libtomcrypt PRIVATE ${libtomcrypt_src})
target_include_directories(libtomcrypt PUBLIC ${libtomcrypt_SOURCE_DIR}/src/headers)
target_compile_definitions(libtomcrypt PRIVATE LTC_SOURCE LTC_NO_PROTOTYPES LTC_NO_TEST LTC_NO_FILE)

# import targets：
# libtomcrypt::libtomcrypt
