include(FetchContent)

message(STATUS "get entt ...")

FetchContent_Declare(
  entt
  URL https://github.com/skypjack/entt/archive/v3.15.0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(entt)
if(NOT entt_POPULATED)
  FetchContent_MakeAvailable(entt)
endif()

# import targets:
# EnTT::EnTT
