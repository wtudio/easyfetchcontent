include(FetchContent)

message(STATUS "get paho_mqtt_cpp ...")

FetchContent_Declare(
  paho_mqtt_cpp
  URL https://github.com/eclipse/paho.mqtt.cpp/archive/v1.2.0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(paho_mqtt_cpp)
if(NOT paho_mqtt_cpp_POPULATED)
  include(GetPahoMqttC)

  if(PAHO_WITH_SSL)
    set(PAHO_MQTT_C_INCLUDE_DIRS $<TARGET_PROPERTY:paho_mqtt_c::paho-mqtt3as,INCLUDE_DIRECTORIES>)
    set(PAHO_MQTT_C_LIBRARIES ${paho_mqtt_c_BINARY_DIR}/src/libpaho-mqtt3as.so)
  else()
    set(PAHO_MQTT_C_INCLUDE_DIRS $<TARGET_PROPERTY:paho_mqtt_c::paho-mqtt3a,INCLUDE_DIRECTORIES>)
    set(PAHO_MQTT_C_LIBRARIES ${paho_mqtt_c_BINARY_DIR}/src/libpaho-mqtt3a.so)
  endif()

  FetchContent_MakeAvailable(paho_mqtt_cpp)

  if(TARGET paho-mqttpp3)
    add_library(paho_mqtt_cpp::paho-mqttpp3 ALIAS paho-mqttpp3)
  endif()

  if(TARGET paho-mqttpp3-static)
    add_library(paho_mqtt_cpp::paho-mqttpp3-static ALIAS paho-mqttpp3-static)
  endif()

endif()

# import targets:
# paho_mqtt_cpp::paho-mqttpp3
# paho_mqtt_cpp::paho-mqttpp3-static
