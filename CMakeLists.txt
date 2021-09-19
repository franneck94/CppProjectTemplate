cmake_minimum_required(VERSION 3.14)

set(PROJECT "CppTemplate")
project("${PROJECT}_Project" VERSION 1.2.3 LANGUAGES CXX)

# Global CMake variables are set here
set(CMAKE_CXX_STANDARD              17)
set(CMAKE_CXX_STANDARD_REQUIRED     ON)
set(CMAKE_CXX_EXTENSIONS            OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS   ON)

# Options
option(ENABLE_WARNINGS      "Enable to add warnings to a target."   ON)
option(ENABLE_TESTING       "Enable a Unit Testing build."          ON)
option(ENABLE_COVERAGE      "Enable a Code Coverage build."         OFF)
option(ENABLE_BENCHMARKS    "Enable a benchmark build."             ON)
option(ENABLE_CLANG_TIDY    "Enable a clang tidy checks."           OFF)
option(ENABLE_CPPCHECK      "Enable a cppcheck checks."             OFF)
option(ENABLE_LTO           "Enable Link Time Optimization (LTO)."  OFF)
option(ENABLE_CCACHE        "Enable the usage of Ccache."           OFF)

# Cmake modules
set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/)
include(ConfigSafeGuards)
include(Warnings)
include(Documentation)
if (ENABLE_TESTING OR ENABLE_COVERAGE)
    include(CTest)
endif()
if (ENABLE_COVERAGE)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        include(CodeCoverage)
    else()
        message("Coverage only for GNU|Clang")
        set(ENABLE_COVERAGE OFF)
    endif()
endif()
if (ENABLE_CLANG_TIDY OR ENABLE_CPPCHECK)
    include(StaticAnalyzers)
endif()
if (ENABLE_LTO)
    include(LTO)
    find_lto(CXX)
endif()
if (ENABLE_CCACHE)
    include(Ccache)
endif()

# Project/Library Names
set(LIBRARY_NAME    ${PROJECT}_MyLib)
set(EXECUTABLE_NAME ${PROJECT}_Executable)
set(TEST_MAIN       ${PROJECT}_unit_tests)
set(COVERAGE_MAIN   ${PROJECT}_coverage)
set(BENCHMARK_MAIN  ${PROJECT}_benchmarks)

# Add conan libraries
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# Add external libraries
find_package(Git QUIET)

if(GIT_FOUND)
    message(STATUS "Submodule update")
    execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                    RESULT_VARIABLE GIT_SUBMOD_RESULT)
endif()

add_subdirectory(external)

# Add first-party libraries
add_subdirectory(src)

# Add executables
add_subdirectory(app)

# Add unit tests
if (ENABLE_TESTING OR ENABLE_COVERAGE)
    enable_testing()
    add_subdirectory(tests)
endif()

# Add benchmarks
if (ENABLE_BENCHMARKING)
    add_subdirectory(benchmarks)
endif()

install(TARGETS ${EXECUTABLE_NAME}
        EXPORT ${LIBRARY_NAME}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin)

install(TARGETS ${LIBRARY_NAME}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)
