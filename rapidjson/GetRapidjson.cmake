include(FetchContent)

message(STATUS "get rapidjson ...")

FetchContent_Declare(
  rapidjson
  URL  https://github.com/Tencent/rapidjson/archive/v1.1.0.tar.gz
)

FetchContent_GetProperties(rapidjson)
if(NOT rapidjson_POPULATED)
  FetchContent_Populate(rapidjson)
endif()

add_library(rapidjson INTERFACE)
add_library(rapidjson::rapidjson ALIAS rapidjson)

target_include_directories(rapidjson INTERFACE ${rapidjson_SOURCE_DIR}/include)

# import targets：
# rapidjson::rapidjson
