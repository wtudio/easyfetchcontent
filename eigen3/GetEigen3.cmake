include(FetchContent)

message(STATUS "get eigen3 ...")

FetchContent_Declare(
  eigen3
  URL  https://gitlab.com/libeigen/eigen/-/archive/969c31eefcdfaab11da763bea3f7502086673ab0/eigen-969c31eefcdfaab11da763bea3f7502086673ab0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

FetchContent_GetProperties(eigen3)
if(NOT eigen3_POPULATED)
  set(EIGEN_BUILD_DOC OFF CACHE BOOL "")
  set(EIGEN_BUILD_TESTING OFF CACHE BOOL "")
  set(EIGEN_BUILD_TESTING OFF CACHE BOOL "")

  FetchContent_MakeAvailable(eigen3)
endif()

# import targets:
# Eigen3::Eigen
