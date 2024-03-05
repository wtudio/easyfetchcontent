cmake_minimum_required(VERSION 3.26)

set(PRJ_NAME "TestPahoMqttC")

project(${PRJ_NAME})
message(STATUS "start cmake ${PRJ_NAME} ...")

# enable c++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# download and import dep
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
include(GetPahoMqttC)

# define src files
file(GLOB server_srcs ${CMAKE_CURRENT_SOURCE_DIR}/server/*.cpp)
file(GLOB client_srcs ${CMAKE_CURRENT_SOURCE_DIR}/client/*.cpp)

# add target
add_executable(${PRJ_NAME}_server)
add_executable(${PRJ_NAME}_client)

# set src files
target_sources(${PRJ_NAME}_server PRIVATE ${server_srcs})
target_sources(${PRJ_NAME}_client PRIVATE ${client_srcs})

# set head include path
target_include_directories(
  ${PRJ_NAME}_server
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

target_include_directories(
  ${PRJ_NAME}_client
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# set link target
target_link_libraries(
  ${PRJ_NAME}_server
  PRIVATE paho_mqtt_c::paho-mqtt3as-static
          paho_mqtt_c::paho-mqtt3cs-static)

target_link_libraries(
  ${PRJ_NAME}_client
  PRIVATE paho_mqtt_c::paho-mqtt3as-static
          paho_mqtt_c::paho-mqtt3cs-static)
