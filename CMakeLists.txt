cmake_minimum_required(VERSION 3.12)

set(PROJECT "CppTemplate")

project("${PROJECT}_Project" VERSION 1.2.3 LANGUAGES CXX)

# Global CMake variables are set here
set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

# Compile options
if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    add_compile_options(
        "$<$<CONFIG:DEBUG>:/Od;>"
        "$<$<CONFIG:RELEASE>:/Ox>")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options(
        "$<$<CONFIG:DEBUG>:-O0;-g3;-ggdb>"
        "$<$<CONFIG:RELEASE>:-O3>")
endif()

# Options
option(ENABLE_WARNINGS   "Enable to add warnings to a target."  ON)
option(ENABLE_COVERAGE   "Enable a Code Coverage build."        OFF)
option(ENABLE_BENCHMARKS "Enable a Benchmark build"             OFF)

# Include CMake modules
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
include(Documentation)
include(CTest)
include(ConfigSafeGuards)
include(Warnings)
if(ENABLE_COVERAGE)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        include(CodeCoverage)
    else()
        message("You must use a GNU or Clang Compiler for CodeCoverage!")
    endif()
endif()

# First party packages
set(LIBRARY_NAME    "${PROJECT}_MyLib")
set(MAIN            "${PROJECT}_executable")
set(TEST_MAIN       "${PROJECT}_unit_tests")

# Add external packages with conan
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

target_set_warnings(TARGET CONAN_PKG::cxxopts ENABLE OFF AS_ERROR OFF)
target_set_warnings(TARGET CONAN_PKG::celero ENABLE OFF AS_ERROR OFF)
target_set_warnings(TARGET CONAN_PKG::boost ENABLE OFF AS_ERROR OFF)
target_set_warnings(TARGET CONAN_PKG::catch2 ENABLE OFF AS_ERROR OFF)

# Add external packages by cloning
add_subdirectory(external)

# Add libraries
add_subdirectory(src)

# Add executables
add_subdirectory(app)

# Add tests
add_subdirectory(tests)

# Add benchmarks
add_subdirectory(benchmarks)
