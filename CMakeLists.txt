cmake_minimum_required(VERSION 3.12)

set(NAME CppTemplate)
project("${NAME}_Project" VERSION 1.1 LANGUAGES CXX)

# Global CMake variables are set here
set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

# Project/Library Names
set(LIBRARY_NAME    "${NAME}_Lib")
set(MAIN            "${NAME}_Executable")

# External Library Names
set(LIBRARY_LINALG  LinAlg)
set(LIBRARY_LOG     loguru)
set(LIBRARY_BENCH   celero)

# Options: Things you can set via commandline options to cmake (e.g. -DENABLE_LTO=[ON|OFF])
option(ENABLE_WARNINGS  "Allow target_set_warnings to add flags and defines."   ON)
option(USE_BENCHMARKS   "Create a Benchmark-enabled build."                     OFF)
option(USE_GCOV         "Create a GCov-enabled build."                          OFF)

# Include stuff. No change needed.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake/")
include(ConfigSafeGuards)
include(CTest)
include(Documentation)
include(Warnings)
if(USE_GCOV)
    if (CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        include(CodeCoverage)
        message("Including CodeCoverage")
    else()
        message("You must use a GNU or Clang Compiler for CodeCoverage")
    endif()
endif()

# Link Conan Packages
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# Link External Libraries
add_subdirectory(external)

# Link Libraries
add_subdirectory(src)

# Main Executable
add_subdirectory(app)

# Test Executable
add_subdirectory(tests)

# Test Benchmarks
add_subdirectory(benchmarks)
