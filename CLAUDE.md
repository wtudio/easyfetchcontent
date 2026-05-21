# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A collection of reusable CMake modules that fetch and configure third-party C/C++ libraries via CMake's `FetchContent`. Each library lives in its own directory containing a `GetXxx.cmake` module (the reusable artifact) and a demo `CMakeLists.txt` + `main.cpp` showing usage.

## Build Commands

Test a single library (e.g., fmt):
```bash
cmake -B build -S fmt && cmake --build build
```

Do NOT build from the root with all subdirectories uncommented — there are known conflicts between some libraries.

## Formatting

```bash
./format.sh
```

This runs `clang-format` (Google style, unlimited column width) on C++/proto files and `cmake-format` on CMake files, both excluding `build/`.

## Architecture

Each library directory follows the same pattern:
- `GetXxx.cmake` — standalone FetchContent module that declares, downloads, configures, and exposes import targets. This is the file users copy into their own projects.
- `CMakeLists.txt` — minimal demo project that includes the Get module and links a test executable.
- `main.cpp` — trivial usage example.

Some libraries with transitive dependencies (e.g., `opentelemetry_cpp`, `grpc`, `paho_mqtt_cpp`) include multiple Get modules in their directory for the full dependency chain.

## Adding a New Library

1. Create a directory named after the library.
2. Write a `GetXxx.cmake` that uses `FetchContent_Declare`/`FetchContent_MakeAvailable`, sets necessary cache variables, and documents the import targets in a trailing comment.
3. Add a demo `CMakeLists.txt` that includes the module via `CMAKE_MODULE_PATH` and links the target.
4. Add a `main.cpp` that exercises the library minimally.
5. Add an entry to the root `CMakeLists.txt` (commented out) and `README.md`.
6. Run `./format.sh` before committing.

## CMake Conventions

- Minimum CMake version: 3.26
- Get modules use `FetchContent_GetProperties` + `if(NOT xxx_POPULATED)` guard to avoid double-fetch.
- Configuration options are set as `CACHE` variables before `FetchContent_MakeAvailable`.
- Import targets are listed in a comment at the end of each Get module.
