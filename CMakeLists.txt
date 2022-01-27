cmake_minimum_required(VERSION 3.20)

project(EasyFetchContentTestAll VERSION 0.1.0 LANGUAGES C CXX)

# add all test
add_subdirectory(fmt)
add_subdirectory(protobuf)
add_subdirectory(gflags)
add_subdirectory(jsoncpp)
add_subdirectory(leveldb)
add_subdirectory(rapidjson)
add_subdirectory(lua)
add_subdirectory(snappy)
add_subdirectory(sqlite)
add_subdirectory(yamlcpp)
add_subdirectory(tinyxml2)
add_subdirectory(libtomcrypt)
add_subdirectory(asio)
add_subdirectory(robinhood)
add_subdirectory(libevent)
add_subdirectory(spdlog)

add_subdirectory(gtest)
add_subdirectory(googlebenchmark)
