cmake_minimum_required(VERSION 3.12)

set(PROJECT "CppTemplate")

project("${PROJECT}_Project" VERSION 1.2.3 LANGUAGES CXX)

# Global CMake variables are set here
set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

# Project/Library Names
set(LIBRARY_NAME    "${PROJECT}_MyLib")
set(LIBRARY_LINALG  "${PROJECT}_LinAlg")
set(LIBRARY_LOG     "${PROJECT}_loguru")
set(LIBRARY_BENCH   "${PROJECT}_celero")
set(MAIN            "${PROJECT}_Executable")
set(TEST_MAIN       "${PROJECT}_unit_tests")

# Options
option(ENABLE_WARNINGS  "Allow target_set_warnings to add warnings."    ON)
option(USE_GCOV         "Create a GCov-enabled build."                  OFF)
option(USE_BENCHMARKS   "Create a Benchmark-enabled build"              OFF)

# Configuration Files
configure_file("${PROJECT_SOURCE_DIR}/include/ProjectConfig.h.in"
               "${PROJECT_BINARY_DIR}/ProjectConfig.h" @ONLY)

# Include own cmake modules
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
include(Documentation)
include(CTest)
include(ConfigSafeGuards)
include(Warnings)
if(USE_GCOV)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        include(CodeCoverage)
    else()
        message("You must use a GNU or Clang Compiler for CodeCoverage!")
    endif()
endif()

# Add conan packages
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# Add externals
add_subdirectory(external)

# Add libraries
add_subdirectory(src)

# Add executables
add_subdirectory(app)

# Add tests
add_subdirectory(tests)

# Add benchmarks
add_subdirectory(benchmarks)
