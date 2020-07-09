[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://api.travis-ci.org/franneck94/Cpp-Project-Template.svg?branch=master)](https://travis-ci.org/github/franneck94/Cpp-Project-Template)
[![codecov](https://codecov.io/gh/bsamseth/cpp-project/branch/master/graph/badge.svg)](https://codecov.io/gh/bsamseth/cpp-project)


# Template for C++ projects 

This is a template for C++ projects. What you get:

-   Sources, headers and test files separated in distinct folders
-   External libraries installed and managed by [Conan](https://conan.io/)
-   Use of modern [CMake](https://cmake.org/) for building and compiling
-   Setup for tests using [GTest](https://github.com/google/googletest)
-   Continuous testing with [Travis-CI](https://travis-ci.org/) (Linux/MacOS) and [Appveyor](https://www.appveyor.com) (Windows)
-   Code coverage reports, including automatic upload to [Codecov.io](https://codecov.io)
-   Code documentation with [Doxygen](http://www.stack.nl/~dimitri/doxygen/)
-   Optional: Use of the [Visual Studio Code](https://code.visualstudio.com/) IDE with useful Extensions

## Structure
``` text
├── conanfile.txt
├── CMakeLists.txt
├── app
│   └── main.cc
└── documentation
│   ├── Doxyfile.in
├── include
│   ├── dummy.h
├── src
│   └── dummy.cc
└── tests
    ├── CMakeLists.txt
    ├── test_dummy.cc
    └── main.cc
```

Sources go in [src/](src/), header files in [include/](include/), main programs in [app/](app),
tests go in [tests/](tests/).

If you add a new executable, say `app/new_executable.cc`, you only need to add the following two lines to [CMakeLists.txt](CMakeLists.txt): 

``` cmake
add_executable(new_executable app/new_executable.cc)   # Name of exec. and location of file.
target_link_libraries(new_executable PRIVATE ${LIBRARY_NAME})  # Link the executable to lib built from src/*.cc (if it uses it).
```

You can find the example source code that builds the `main` executable in [app/main.cc](app/main.cc) under the `Build` section in [CMakeLists.txt](CMakeLists.txt). 
If the executable you made does not use the library in [src/](src), then only the first line is needed.
