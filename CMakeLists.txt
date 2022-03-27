cmake_minimum_required(VERSION 3.14)

set(PROJECT "CppTemplate")

project("Project" VERSION 1.2.3 LANGUAGES C CXX)

# Global CMake variables are set here
set(CMAKE_CXX_STANDARD              17)
set(CMAKE_CXX_STANDARD_REQUIRED     ON)
set(CMAKE_CXX_EXTENSIONS            OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS   ON)

# Options
option(ENABLE_WARNINGS      "Enable to add warnings to a target."   ON)
option(ENABLE_TESTING       "Enable a Unit Testing build."          ON)
option(ENABLE_COVERAGE      "Enable a Code Coverage build."         OFF)
option(ENABLE_BENCHMARKS    "Enable a benchmark build."             OFF)
option(ENABLE_CLANG_TIDY    "Enable to add clang tidy."             ON)
option(ENABLE_CPPCHECK      "Enable to add cppcheck."               ON)
option(ENABLE_LTO           "Enable to add Link Time Optimization." ON)
option(ENABLE_CCACHE        "Enable to add Ccache."                 ON)

# Project/Library Names
set(LIBRARY_NAME    "MyLib")
set(EXECUTABLE_NAME "Executable")
set(TEST_MAIN       "unit_tests")
set(COVERAGE_MAIN   "coverage")
set(BENCHMARK_MAIN  "benchmarks")

### CMAKE MODULES

include(ConfigSafeGuards)
include(Warnings)
include(Documentation)
include(StaticAnalyzers)
include(LTO)
include(Ccache)

if (ENABLE_LTO)
    find_lto(CXX)
endif()

if (ENABLE_TESTING)
    enable_testing()
endif()
if (ENABLE_COVERAGE)
    include(CodeCoverage)
endif()

### EXTERNAL LIBRARIES

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

find_package(Git QUIET)
if(GIT_FOUND)
    message(STATUS "Submodule update")
    execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                    RESULT_VARIABLE GIT_SUBMOD_RESULT)
endif()

### SUB DIRECTORIES

add_subdirectory(external)
add_subdirectory(src)
add_subdirectory(app)

if (ENABLE_TESTING)
    add_subdirectory(tests)
endif()

if (ENABLE_BENCHMARKING)
    add_subdirectory(benchmarks)
endif()

### INSTALL TARGETS

install(TARGETS ${EXECUTABLE_NAME}
        EXPORT ${LIBRARY_NAME}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin)

install(TARGETS ${LIBRARY_NAME}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)
