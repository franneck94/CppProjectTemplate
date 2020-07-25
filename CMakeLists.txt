# --------------------------------------------------------------------------------
#                           Project properties
# --------------------------------------------------------------------------------
# This file specifies how the project should be built, using CMake.
cmake_minimum_required(VERSION 3.8.2)

# Set project name, version and laguages here. (change as needed)
project(CPP_PROJECT_TEMPLATE VERSION 1.0 LANGUAGES CXX)

# Options: Things you can set via commandline options to cmake (e.g. -DENABLE_LTO=[ON|OFF])
option(ENABLE_WARNINGS  "Allow target_set_warnings to add flags and defines."   ON)
option(ENABLE_LTO       "Enable link time optimization"                         ON)
option(USE_BENCHMARKS   "Create a Benchmark-enabled build."                     OFF)
option(USE_GCOV         "Create a GCov-enabled build."                          OFF)

# Include stuff. No change needed.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
include(ConfigSafeGuards)
include(CTest)
include(Documentation)
include(LTO)
include(Warnings)

# Check for LTO support.
find_lto(CXX)

# --------------------------------------------------------------------------------
#                           Locally cloned libs.
# --------------------------------------------------------------------------------
add_subdirectory(external)

# --------------------------------------------------------------------------------
#                           Conan installed libs.
# --------------------------------------------------------------------------------
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# --------------------------------------------------------------------------------
#                               Locate files
# --------------------------------------------------------------------------------
# All .cc files in src/
set(SOURCES
    src/dummy.cc
)
# Default name for the library built from src/*.cc
set(LIBRARY_NAME 
    my_library
)

# --------------------------------------------------------------------------------
#                                   Build!
# --------------------------------------------------------------------------------
# Compile all sources into a library.
add_library(${LIBRARY_NAME} OBJECT ${SOURCES})

# Lib needs its header files, and users of the library must also see these (PUBLIC). (No change needed)
target_include_directories(${LIBRARY_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)

# Link header only libaries (change as needed).
target_link_libraries(${LIBRARY_NAME} PUBLIC linalg)
if(WIN32)
    target_link_libraries(${LIBRARY_NAME} PUBLIC loguru)
endif(WIN32)
if(UNIX)
    target_link_libraries(${LIBRARY_NAME} PUBLIC loguru pthread dl)
endif(UNIX)

# Set the compile options you want (change as needed).
target_set_warnings(${LIBRARY_NAME} ENABLE ALL DISABLE Annoying)

# Add an executable for the file app/main.cpp.
set(MAIN main)   # Default name for test executable (change if you wish).
add_executable(${MAIN} app/main.cc)   # Name of exec. and location of file.
target_link_libraries(${MAIN} PRIVATE ${LIBRARY_NAME})

# Set the properties you require, e.g. what C++ standard to use. 
# Here applied to library and main (change as needed).
set_target_properties(
    ${LIBRARY_NAME} ${MAIN} 
      PROPERTIES 
        CXX_STANDARD 17 
        CXX_STANDARD_REQUIRED YES
)

# Set up tests (see tests/CMakeLists.txt).
add_subdirectory(tests)
# Set up benchmarks (see benchmarks/CMakeLists.txt).
add_subdirectory(benchmarks)
