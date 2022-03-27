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
option(ENABLE_CLANG_TIDY    "Enable to add clang tidy."             ON)
option(ENABLE_CPPCHECK      "Enable to add cppcheck."               ON)
option(ENABLE_LTO           "Enable to add Link Time Optimization." ON)
option(ENABLE_CCACHE        "Enable to add Ccache."                 ON)

# Project/Library Names
set(LIBRARY_NAME    "lib")
set(EXECUTABLE_NAME "main")
set(TEST_MAIN       "unit_tests")
set(COVERAGE_MAIN   "coverage")

### CMAKE MODULES

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/)
include(ConfigSafeGuards)
include(Warnings)
include(Docs)
include(CodeCoverage)
include(AddGitSubmodule)
include(FetchContent)

include(StaticAnalyzers)
include(LTO)
include(Ccache)

if (ENABLE_LTO)
    find_lto(CXX)
endif()

### EXTERNAL LIBRARIES

add_git_submodule(external/json)

FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 8.1.1)
FetchContent_MakeAvailable(fmt)

FetchContent_Declare(
    spdlog
    GIT_REPOSITORY https://github.com/gabime/spdlog
    GIT_TAG v1.9.2)
FetchContent_MakeAvailable(spdlog)

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

### SUB DIRECTORIES

add_subdirectory(external)
add_subdirectory(src)
add_subdirectory(app)
add_subdirectory(tests)

### INSTALL TARGETS

install(TARGETS ${EXECUTABLE_NAME}
        EXPORT ${LIBRARY_NAME}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin)

install(TARGETS ${LIBRARY_NAME}
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib)
