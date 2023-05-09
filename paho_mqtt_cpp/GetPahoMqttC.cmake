include(FetchContent)

message(STATUS "get paho_mqtt_c ...")

FetchContent_Declare(
  paho_mqtt_c
  URL  https://github.com/eclipse/paho.mqtt.c/archive/v1.3.12.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

FetchContent_GetProperties(paho_mqtt_c)
if(NOT paho_mqtt_c_POPULATED)
  set(PAHO_ENABLE_TESTING OFF CACHE BOOL "")

  FetchContent_MakeAvailable(paho_mqtt_c)

  if(TARGET paho-mqtt3c)
    add_library(paho_mqtt_c::paho-mqtt3c ALIAS paho-mqtt3c)
  endif()

  if(TARGET paho-mqtt3a)
    add_library(paho_mqtt_c::paho-mqtt3a ALIAS paho-mqtt3a)
  endif()

  if(TARGET paho-mqtt3c-static)
    add_library(paho_mqtt_c::paho-mqtt3c-static ALIAS paho-mqtt3c-static)
  endif()

  if(TARGET paho-mqtt3a-static)
    add_library(paho_mqtt_c::paho-mqtt3a-static ALIAS paho-mqtt3a-static)
  endif()

  if(TARGET paho-mqtt3cs)
    add_library(paho_mqtt_c::paho-mqtt3cs ALIAS paho-mqtt3cs)
  endif()

  if(TARGET paho-mqtt3as)
    add_library(paho_mqtt_c::paho-mqtt3as ALIAS paho-mqtt3as)
  endif()

  if(TARGET paho-mqtt3cs-static)
    add_library(paho_mqtt_c::paho-mqtt3cs-static ALIAS paho-mqtt3cs-static)
  endif()

  if(TARGET paho-mqtt3as-static)
    add_library(paho_mqtt_c::paho-mqtt3as-static ALIAS paho-mqtt3as-static)
  endif()

endif()

# import targets:
# paho_mqtt_c::paho-mqtt3c
# paho_mqtt_c::paho-mqtt3a
# paho_mqtt_c::paho-mqtt3c-static
# paho_mqtt_c::paho-mqtt3a-static
# paho_mqtt_c::paho-mqtt3cs
# paho_mqtt_c::paho-mqtt3as
# paho_mqtt_c::paho-mqtt3cs-static
# paho_mqtt_c::paho-mqtt3as-static
