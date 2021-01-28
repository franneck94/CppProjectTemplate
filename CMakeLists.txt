cmake_minimum_required(VERSION 3.14)

# ---- Project ----

set(PROJECT "CppTemplate")
project("${PROJECT}_Project" VERSION 1.2.3 LANGUAGES CXX)

# ---- Global settings ----

set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    add_compile_options(
        "$<$<CONFIG:DEBUG>:/Od;>"
        "$<$<CONFIG:RELEASE>:/Ox>")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options(
        "$<$<CONFIG:DEBUG>:-O0;-g3;-ggdb>"
        "$<$<CONFIG:RELEASE>:-O3>")
endif()

# ---- Options ----

option(ENABLE_WARNINGS      "Enable to add warnings to a target."  ON)
option(ENABLE_TESTING       "Enable a Unit Test build."            ON)
option(ENABLE_COVERAGE      "Enable a Code Coverage build."        OFF)
option(ENABLE_BENCHMARKING  "Enable a Benchmark build"             OFF)

# ---- CMake modules ----

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")
include(ConfigSafeGuards)
include(Warnings)
if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    include(Documentation)
    include(CTest)
    if(ENABLE_COVERAGE)
        if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
            include(CodeCoverage)
        else()
            message("Coverage only for GNU|Clang.")
            set(ENABLE_COVERAGE OFF)
        endif()
    endif()
endif()

# ---- Package names ----

set(LIBRARY_NAME    "${PROJECT}_MyLib")
set(MAIN            "${PROJECT}_executable")
set(TEST_MAIN       "${PROJECT}_unit_tests")

# ---- External conan packages ----

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# target_set_warnings(TARGET CONAN_PKG::cxxopts ENABLE OFF AS_ERROR OFF)
# target_set_warnings(TARGET CONAN_PKG::celero ENABLE OFF AS_ERROR OFF)
# target_set_warnings(TARGET CONAN_PKG::boost ENABLE OFF AS_ERROR OFF)
# target_set_warnings(TARGET CONAN_PKG::catch2 ENABLE OFF AS_ERROR OFF)

# ---- External git packages ----

add_subdirectory(external)

# ---- First party library ----

add_subdirectory(src)

# ---- First party application ----

add_subdirectory(app)

# ---- Unit test and coverage ----

if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    if (ENABLE_TESTING OR ENABLE_COVERAGE)
        enable_testing()
        add_subdirectory(tests)
    endif()
endif()

# ---- Bechmarks ----

if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    if (ENABLE_BENCHMARKING)
        message(${CMAKE_BUILD_TYPE})
        if (CMAKE_BUILD_TYPE STREQUAL "Release")
            add_subdirectory(benchmarks)
        else()
            message("Benchmarking only in release mode.")
        endif()
    endif()
endif()
