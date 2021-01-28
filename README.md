# Template For C++ Projects

![C++](https://camo.githubusercontent.com/c59efb57803dde7f352f4932a468a7f39fa2fb5f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f632532422532422d31312f31342f31372f32302d626c75652e737667)
![License](https://camo.githubusercontent.com/890acbdcb87868b382af9a4b1fac507b9659d9bf/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c6963656e73652d4d49542d626c75652e737667)
![Build CI Test](https://github.com/franneck94/Cpp-Project-Template/workflows/Ubuntu%20CI%20Test/badge.svg)
[![codecov](https://codecov.io/gh/franneck94/Cpp-Project-Template/branch/master/graph/badge.svg)](https://codecov.io/gh/franneck94/Cpp-Project-Template)

This is a template for C++ projects. What you get:

- Sources, headers and test files separated in distinct folders.
- External libraries that are locally cloned by [Github](https://github.com).
- External libraries installed and managed by [Conan](https://conan.io/).
- Use of modern [CMake](https://cmake.org/) for building and compiling.
- Unit testing, using [Catch2](https://github.com/catchorg/Catch2), Logging, using [Loguru](https://github.com/emilk/loguru) and Benchmarking, using [Celero](https://github.com/DigitalInBlue/Celero).
- Continuous testing with Github Actions.
- Code coverage reports, including automatic upload to [Codecov](https://codecov.io).
- Code documentation with [Doxygen](http://www.stack.nl/~dimitri/doxygen/).
- Optional: Use of [VSCode](https://code.visualstudio.com/) with the C/C++ and CMakeTools extension.

## Structure

``` text
├── CMakeLists.txt
├── app
│   ├── CMakesLists.txt
│   └── main.cc
├── benchmarks
│   ├── CMakesLists.txt
│   └── main.cc
├── docs
├── ├── Doxyfile
│   └── html/
├── external
│   ├── CMakesLists.txt
│   ├── linalg/
│   └── loguru/
├── include
│   └── my_lib.h
├── src
│   ├── CMakesLists.txt
│   └── my_lib.cc
└── tests
  ├── CMakeLists.txt
  └── main.cc
```

Sources go in [src/](src/), header files in [include/](include/), main programs in [app/](app),
tests go in [tests/](tests/) and benchmarks go in [benchmarks/](benchmarks/).

If you add a new executable, say `app/new_executable.cc`, you only need to add the following two lines to [CMakeLists.txt](CMakeLists.txt):

```shell
add_executable(new_executable app/new_executable.cc) # Name of exec. and location of file.
target_link_libraries(new_executable PRIVATE ${LIBRARY_NAME})  # Link the executable to lib built from src/*.cc (if it uses it).
```

## Software Requirements

- CMake 3.14+
- GNU Makefile
- Doxygen
- Conan
- MSVC 2017 (or higher), G++7 (or higher), Clang++7 (or higher)
- Code Covergae (only on GNU|Clang): lcov, gcovr

## Run CMake Targets

- App Executable:
The build type can be Debug/Release/MinSizeRel or RelWithDebInfo

```shell
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . --config Release --target CppTemplate_executable
./bin/CppTemplate_executable
```

- Code Coverage:
The build type has to be Coverage.

```shell
cd build
cmake -DCMAKE_BUILD_TYPE=Coverage -DENABLE_CODE_COVERAGE=ON ..
cmake --build . --config Coverage --target CppTemplate_coverage
```

- Unit testing:
The build type should to be Debug for GCC/Clang and Release for MSVC (due to bug).

```shell
cd build
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build . --config Debug --target CppTemplate_unit_tests
./bin/CppTemplate_unit_tests
```

- Benchmarking:
The build type should to be Release.

```shell
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_BENCHMARKS=ON ..
cmake --build . --config Release --target CppTemplate_benchmarks
./bin/CppTemplate_benchmarks
```

- Documentation:

```shell
cd build
cmake -DCMAKE_BUILD_TYPE=Debug ..
cmake --build . --config Debug --target CppTemplate_docs
```

## CMake Tutorial

### Generating a Project

```shell
 cmake [<options>] -S <path-to-source> -B <path-to-build>
```

Assuming that a CMakeLists.txt is in the root directory, you can generate a project like the following.

```shell
 mkdir build
 cd build
 cmake -S .. -B . # Option 1
 cmake .. # Option 2
```

Assuming that you have already build the CMake project, you can update the generated project.

```shell
 cd build
 cmake .
```

### Generator for GCC and Clang

```shell
 cd build
 cmake -S .. -B . -G "Unix Makefiles" # Option 1
 cmake .. -G "Unix Makefiles" # Option 2
```

### Generator for MSVC

```shell
 cd build
 cmake -S .. -B . -G "Visual Studio 16 2019" # Option 1
 cmake .. -G "Visual Studio 16 2019" # Option 2
```

### Specify the Build Type

Per default the standard type is in the most cases the debug type.
If you want to generate the project, for example, in release mode you have to set the build type.

```shell
 cd build
 cmake -DCMAKE_BUILD_TYPE=Release ..
```

### Passing Options

If you have set some options in the CMakeLists, you can pass values in the command line.

```shell
 cd build
 cmake -DMY_OPTION=[ON|OFF] .. 
```

## Build a Project

To build a project, you need to generate it beforehand.
Building a project is pretty straightforward, by typing the following.

```shell
 cmake --build <dir> [<options>] [-- <build-tool-options>]
```

If you want to build the project in parallel you can use the following option.

```shell
 cd build
 cmake --build .
```

### Specify the Build Target (Option 1)

The standard build command would build all created targets within the CMakeLists.
If you want to build a specific target, you can do so.

```shell
 cd build
 cmake --build . --target ExternalLibraries_Executable
```

The target *ExternalLibraries_Executable* is just an example of a possible target name.
Note: All dependent targets will be build beforehand.

### Specify the Build Target (Option 2)

Besides setting the target within the cmake build command, you could also run the previously generated Makefile (from the generating step).
If you want to build the *ExternalLibraries_Executable*, you could to the following.

```shell
 cd build
 make ExternalLibraries_Executable
```

## Run the Executable

After generating the project and building a specific target you might want to run the executable.
In the default case, the executable is stored in *build/5_ExternalLibraries/app/ExternalLibraries_Executable*, assuming that you are building the project *5_ExternalLibraries* and the main file of the executable is in the *app* dir.

```shell
 cd build
 ./bin/ExternalLibraries_Executable
```

## Different Linking Types

There are the three following linking types:

- PRIVATE: When A links in B as *PRIVATE*, it is saying that A uses B in its
implementation, but B is not used in any part of A's public API. Any code
that makes calls into A would not need to refer directly to anything from
B.
- INTERFACE: When A links in B as *INTERFACE*, it is saying that A does not use B
in its implementation, but B is used in A's public API. Code that calls
into A may need to refer to things from B in order to make such calls.
- PUBLIC: When A links in B as *PUBLIC*, it is essentially a combination of
PRIVATE and INTERFACE. It says that A uses B in its implementation and B is
also used in A's public API.

## Different Library Types

- Shared: Shared libraries reduce the amount of code that is duplicated in each program that makes use of the library, keeping the binaries small. It also allows you to replace the shared object with one that is functionally equivalent, without needing to recompile the program that makes use of it. Shared libraries will, however have a small additional cost for the execution.
- Static: Static libraries increase the overall size of the binary, but it means that you don't need to carry along a copy of the library that is being used. As the code is connected at compile time there are not any additional run-time loading costs. The code is simply there.
