# CMake Tutorial

## Generating a Project

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

## Generator for GCC and Clang

```shell
 cd build
 cmake -S .. -B . -G "Unix Makefiles" # Option 1
 cmake .. -G "Unix Makefiles" # Option 2
```

## Generator for MSVC

```shell
 cd build
 cmake -S .. -B . -G "Visual Studio 16 2019" # Option 1
 cmake .. -G "Visual Studio 16 2019" # Option 2
```

## Specify the Build Type

Per default the standard type is in the most cases the debug type.
If you want to generate the project, for example, in release mode you have to set the build type.

```shell
 cd build
 cmake -DCMAKE_BUILD_TYPE=Release ..
```

## Passing Options

If you have set some options in the CMakeLists, you can pass values in the command line.

```shell
 cd build
 cmake -DMY_OPTION=[ON|OFF] .. 
```

# Build a Project

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

## Specify the Build Target (Option 1)

The standard build command would build all created targets within the CMakeLists.
If you want to build a specific target, you can do so.

```shell
 cd build
 cmake --build . --target ExternalLibraries_Executable
```

The target *ExternalLibraries_Executable* is just an example of a possible target name.
Note: All dependent targets will be built beforehand.

## Specify the Build Target (Option 2)

Besides setting the target within the cmake build command, you could also run the previously generated Makefile (from the generating step).  
If you want to build the *ExternalLibraries_Executable*, you could do the following.

```shell
 cd build
 make ExternalLibraries_Executable
```

# Run the Executable

After generating the project and building a specific target you might want to run the executable.  
In the default case, the executable is stored in *build/5_ExternalLibraries/app/ExternalLibraries_Executable*, assuming that you are building the project *5_ExternalLibraries* and the main file of the executable is in the *app* dir.

```shell
 cd build
 ./bin/ExternalLibraries_Executable
```

# Different Linking Types

There are the three following linking types:

- PRIVATE: When A links in B as *PRIVATE*, it is saying that A uses B in its
implementation, but B is not used in any part of A's public API.  
Any code
that makes calls into A would not need to refer directly to anything from B.
- INTERFACE: When A links in B as *INTERFACE*, it is saying that A does not use B in its implementation, but B is used in A's public API.  
Code that calls into A may need to refer to things from B to make such calls.
- PUBLIC: When A links in B as *PUBLIC*, it is essentially a combination of
PRIVATE and INTERFACE.  
It says that A uses B in its implementation and B is
also used in A's public API.

# Different Library Types

- Shared: Shared libraries reduce the amount of code that is duplicated in each program that makes use of the library, keeping the binaries small.  
It also allows you to replace the shared object with one that is functionally equivalent, without needing to recompile the program that makes use of it.  
Shared libraries will however have a small additional cost for the execution.
- Static: Static libraries increase the overall size of the binary, but it means that you don't need to carry along a copy of the library that is being used.  
As the code is connected at compile time there are not any additional run-time loading costs. The code is simply there.
