include(FetchContent)

message(STATUS "get nlohmann_json ...")

FetchContent_Declare(
  nlohmann_json
  URL https://github.com/nlohmann/json/archive/v3.10.5.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
  OVERRIDE_FIND_PACKAGE)

FetchContent_MakeAvailable(nlohmann_json)

# import targets:
# nlohmann_json::nlohmann_json
