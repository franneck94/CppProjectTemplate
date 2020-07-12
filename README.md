![C++](https://camo.githubusercontent.com/c59efb57803dde7f352f4932a468a7f39fa2fb5f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f632532422532422d31312f31342f31372f32302d626c75652e737667)
![License](https://camo.githubusercontent.com/890acbdcb87868b382af9a4b1fac507b9659d9bf/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f6c6963656e73652d4d49542d626c75652e737667)
[![Release](https://img.shields.io/github/v/release/franneck94/cpp-project-template)](https://travis-ci.org/github/franneck94/Cpp-Project-Template)
[![Project Status: Active.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Travis CI](https://api.travis-ci.org/franneck94/Cpp-Project-Template.svg?branch=master)](https://travis-ci.org/github/franneck94/Cpp-Project-Template)
[![codecov](https://codecov.io/gh/franneck94/Cpp-Project-Template/branch/master/graph/badge.svg)](https://codecov.io/gh/franneck94/Cpp-Project-Template)

# Template For C++ Projects 

This is a template for C++ projects. What you get:

-   Sources, headers and test files separated in distinct folders.
-   External libraries that are locally cloned by [Github](https://github.com).
-   External libraries installed and managed by [Conan](https://conan.io/).
-   Use of modern [CMake](https://cmake.org/) for building and compiling.
-   Setup for tests using [GTest](https://github.com/google/googletest).
-   Continuous testing with [Travis-CI](https://travis-ci.org/).
-   Code coverage reports, including automatic upload to [Codecov](https://codecov.io).
-   Code documentation with [Doxygen](http://www.stack.nl/~dimitri/doxygen/).
-   Optional: Use of [VSCode](https://code.visualstudio.com/) with the C/C++ and CMakeTools extension.

## Structure
``` text
├── conanfile.txt
├── CMakeLists.txt
├── Doxyfile
├── app
│   └── main.cc
└── documentation
│   └── html
├── external
│   ├── linalg
│       └── linalg.h
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
