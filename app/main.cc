#include <iostream>

#include "cxxopts.hpp"

#include "my_lib.h"

auto main(int argc, char **argv) -> int
{
    cout_hello_world();

    cxxopts::Options options("MyProgram", "One line description of MyProgram");

    options.add_options()
        ("d,debug", "Enable debugging", cxxopts::value<bool>())
        ("i,integer", "Int param", cxxopts::value<int>())
        ("f,file", "File name", cxxopts::value<std::string>())
        ("v,verbose", "Verbose output", cxxopts::value<bool>()->default_value("false"));

    auto result = options.parse(argc, argv);

    if (result.count("debug"))
    {
        bool debug = result["debug"].as<bool>();
        std::cout << "debug: " << debug << std::endl;
    }

    if (result.count("integer"))
    {
        int integer = result["integer"].as<int>();
        std::cout << "integer: " << integer << std::endl;
    }

    if (result.count("file"))
    {
        std::string file = result["file"].as<std::string>();
        std::cout << "file: " << file << std::endl;
    }

    if (result.count("verbose"))
    {
        bool verbose = result["verbose"].as<bool>();
        std::cout << "verbose: " << verbose << std::endl;
    }

    int a = 2;

    return 0;
}
