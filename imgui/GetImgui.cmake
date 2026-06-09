include(FetchContent)

message(STATUS "get imgui ...")

# imgui has no top-level CMakeLists.txt, so we only populate the sources here and
# build them into a static library together with a backend (GLFW + OpenGL3).
FetchContent_Declare(
  imgui
  URL https://github.com/ocornut/imgui/archive/v1.92.8.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE)

FetchContent_GetProperties(imgui)
if(NOT imgui_POPULATED)
  FetchContent_MakeAvailable(imgui)

  # the OpenGL3 backend ships its own loader (imgui_impl_opengl3_loader.h), so no
  # glad/glew is needed; we still link OpenGL::GL for the demo's direct gl* calls.
  find_package(OpenGL REQUIRED)

  add_library(imgui STATIC)

  target_sources(
    imgui
    PRIVATE ${imgui_SOURCE_DIR}/imgui.cpp
            ${imgui_SOURCE_DIR}/imgui_draw.cpp
            ${imgui_SOURCE_DIR}/imgui_tables.cpp
            ${imgui_SOURCE_DIR}/imgui_widgets.cpp
            ${imgui_SOURCE_DIR}/imgui_demo.cpp
            ${imgui_SOURCE_DIR}/backends/imgui_impl_glfw.cpp
            ${imgui_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp)

  target_include_directories(imgui PUBLIC $<BUILD_INTERFACE:${imgui_SOURCE_DIR}> $<BUILD_INTERFACE:${imgui_SOURCE_DIR}/backends>)

  target_link_libraries(imgui PUBLIC glfw::glfw OpenGL::GL)

  add_library(imgui::imgui ALIAS imgui)
endif()

# import targets:
# imgui::imgui
