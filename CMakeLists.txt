# --------------------------------------------------------------------------------
#                         Project properties (change as needed).
# --------------------------------------------------------------------------------
# This file specifies how the project should be built, using CMake.
cmake_minimum_required(VERSION 3.8.2)

# Set project name, version and laguages here. (change as needed)
project(CPP_PROJECT_TEMPLATE VERSION 0.1 LANGUAGES C)

# Options: Things you can set via commandline options to cmake (e.g. -DENABLE_LTO=[ON|OFF])
option(ENABLE_CPPCHECK "Enable static analysis with cppcheck" ON)
option(ENABLE_WARNINGS_SETTINGS "Allow target_set_warnings to add flags and defines." ON)
option(ENABLE_LTO "Enable link time optimization" ON)

# Include stuff. No change needed.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")
include(ConfigSafeGuards)
include(CTest)
include(Documentation)
include(Warnings)

# --------------------------------------------------------------------------------
#                         Locally cloned libs (change as needed).
# --------------------------------------------------------------------------------


# --------------------------------------------------------------------------------
#                         Conan installed libs (change as needed).
# --------------------------------------------------------------------------------
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# --------------------------------------------------------------------------------
#                         Locate files (change as needed).
# --------------------------------------------------------------------------------
# All .c files in src/
set(SOURCES
    src/dummy.c
)
# All .c files in tests/
set(TESTFILES
    tests/main.c
)
# Default name for the library built from src/*.c
set(LIBRARY_NAME 
    my_library
)

# --------------------------------------------------------------------------------
#                            Build! (Change as needed)
# --------------------------------------------------------------------------------
# Compile all sources into a library.
add_library(${LIBRARY_NAME} OBJECT ${SOURCES})

# Lib needs its header files, and users of the library must also see these (PUBLIC). (No change needed)
target_include_directories(${LIBRARY_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)

# Set the compile options you want (change as needed).
target_set_warnings(${LIBRARY_NAME} ENABLE ALL DISABLE Annoying)

# Add an executable for the file app/main.c.
# If you add more executables, copy these lines accordingly.
add_executable(main app/main.c)   # Name of exec. and location of file.
target_link_libraries(main PRIVATE ${LIBRARY_NAME})  # Link the executable to library (if it uses it).

# Set the properties you require, e.g. what C++ standard to use. Here applied to library and main (change as needed).
set_target_properties(
    ${LIBRARY_NAME} main 
      PROPERTIES 
        C_STANDARD 11 
        C_STANDARD_REQUIRED YES
)

# Set up tests (see tests/CMakeLists.txt).
add_subdirectory(tests)
