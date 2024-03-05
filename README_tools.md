# Tools

To sum up all the tools we use:

- Compiler warnings: fast checks while compiling the code, for the all target.
- Clang-tidy, CppCheck: linters, can be manually run at any time after their specific targets are built.
- Sanitizers: shows memory leaks in runtime. Built with the all target.
- LTO: applies linking optimization in release mode. Automatically works at compile/linking time for all target
- Doxygen: generates HTML documentation. It can be run apart after build its specific target.
- Clang-format and Cmake-format: allows automatically format the code and CMake files. They can be run apart after build their specific targets.
