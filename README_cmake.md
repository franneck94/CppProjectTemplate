# CMake Tutorial

## Generating a Project

```bash
cmake [<options>] -S <path-to-source> -B <path-to-build>
```

Assuming that a CMakeLists.txt is in the root directory, you can generate a project like the following.

```bash
mkdir build
cd build
cmake -S .. -B . # Option 1
cmake .. # Option 2
```

Assuming that you have already built the CMake project, you can update the generated project.

```bash
cd build
cmake .
```

## Generator for GCC and Clang

```bash
cd build
cmake -S .. -B . -G "Unix Makefiles" # Option 1
cmake .. -G "Unix Makefiles" # Option 2
```

## Generator for MSVC

```bash
cd build
cmake -S .. -B . -G "Visual Studio 16 2019" # Option 1
cmake .. -G "Visual Studio 16 2019" # Option 2
```

## Specify the Build Type

Per default, the standard type is in most cases the debug type.
If you want to generate the project, for example, in release mode you have to set the build type.

```bash
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
```

## Passing Options

If you have set some options in the CMakeLists, you can pass values in the command line.

```bash
cd build
cmake -DMY_OPTION=[ON|OFF] ..
```

## Specify the Build Target (Option 1)

The standard build command would build all created targets within the CMakeLists.
If you want to build a specific target, you can do so.

```bash
cd build
cmake --build . --target ExternalLibraries_Executable
```

The target *ExternalLibraries_Executable* is just an example of a possible target name.
Note: All dependent targets will be built beforehand.

## Specify the Build Target (Option 2)

Besides setting the target within the cmake build command, you could also run the previously generated Makefile (from the generating step).
If you want to build the *ExternalLibraries_Executable*, you could do the following.

```bash
cd build
make ExternalLibraries_Executable
```

## Run the Executable

After generating the project and building a specific target you might want to run the executable.
In the default case, the executable is stored in *build/5_ExternalLibraries/app/ExternalLibraries_Executable*, assuming that you are building the project *5_ExternalLibraries* and the main file of the executable is in the *app* dir.

```bash
cd build
./bin/ExternalLibraries_Executable
```

## Different Linking Types

```cmake
target_link_libraries(A PUBLIC fmt)
target_link_libraries(B PRIVATE spdlog)
```

```cmake
target_link_libraries(C PUBLIC/PRIVATE A)
target_link_libraries(C PUBLIC/PRIVATE B)
```

### PUBLIC

When A links fmt as *PUBLIC*, it says that A uses fmt in its implementation, and fmt is also used in A's public API.
Hence, C can use fmt since it is part of the public API of A.

### PRIVATE

When B links spdlog as *PRIVATE*, it is saying that B uses spdlog in its
implementation, but spdlog is not used in any part of B's public API.

### INTERFACE

```cmake
add_library(D INTERFACE)
target_include_directories(D INTERFACE {CMAKE_CURRENT_SOURCE_DIR}/include)
```

In general, used for header-only libraries.

## Different Library Types

### Shared

Shared libraries reduce the amount of code that is duplicated in each program that makes use of the library, keeping the binaries small. It also allows you to replace the shared object with one that is functionally equivalent, without needing to recompile the program that makes use of it. Shared libraries will however have a small additional cost for the execution.

### Static

Static libraries increase the overall size of the binary, but it means that you don't need to carry along a copy of the library that is being used. As the code is connected at compile time there are not any additional run-time loading costs. The code is simply there.
