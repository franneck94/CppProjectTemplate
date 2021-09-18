#include <iostream>

#include "loguru.hpp"
#include "cxxopts.hpp"

#include "my_lib.h"

auto main(int argc, char **argv) -> int
{
    cout_hello_world();
    print_linalg_vector();
    print_boost_version();

    loguru::init(argc, argv);
    loguru::add_file("everything.log", loguru::Append, loguru::Verbosity_MAX);
    loguru::add_file("info.log", loguru::Append, loguru::Verbosity_INFO);
    loguru::add_file("warning.log", loguru::Append, loguru::Verbosity_WARNING);
    loguru::add_file("error.log", loguru::Append, loguru::Verbosity_ERROR);

    LOG_F(INFO, "Hello this is an info!");
    LOG_F(WARNING, "Hello this is a warning!");
    LOG_F(ERROR, "Hello this is an error!");

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
