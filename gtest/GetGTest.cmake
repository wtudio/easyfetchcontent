include(FetchContent)

message(STATUS "get googletest ...")

FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/release-1.12.1.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(googletest)
if(NOT googletest_POPULATED)
  if(WIN32)
    set(gtest_force_shared_crt
        ON
        CACHE BOOL "")
  endif()
  set(INSTALL_GTEST
      OFF
      CACHE BOOL "")

  FetchContent_MakeAvailable(googletest)
endif()

# import targets:
# GTest::gtest
# GTest::gtest_main
# GTest::gmock
# GTest::gmock_main

# add xxxlib_test target for xxxlib
function(add_gtest_target)
  cmake_parse_arguments(ARG "" "TEST_TARGET" "TEST_SRC;INC_DIR" ${ARGN})
  set(target_test_name ${ARG_TEST_TARGET}_test)

  add_executable(${target_test_name} ${ARG_TEST_SRC})
  target_include_directories(${target_test_name} PRIVATE ${ARG_INC_DIR})
  target_link_libraries(${target_test_name} PRIVATE ${ARG_TEST_TARGET} GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)

  add_test(NAME ${target_test_name} COMMAND $<TARGET_FILE:${target_test_name}>)
endfunction()
