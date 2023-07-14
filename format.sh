#!/bin/bash

# clang-format
find ./ -regex '.*\.cpp\|.*\.h\|.*\.hpp\|.*\.proto' -and -not -regex '\./build/.*' | xargs clang-format -i --style=file

# cmake-format
find ./ -regex '.*\.cmake\|.*CMakeLists\.txt$' -and -not -regex '\./build/.*' | xargs cmake-format -c ./.cmake-format.py -i
