#include <iostream>
#include <fstream>
#include <filesystem>

#include <cxxopts.hpp>
#include <fmt/format.h>
#include <spdlog/spdlog.h>
#include "nlohmann/json.hpp"

#include "config.hpp"
#include "my_lib.h"

using json = nlohmann::json;
namespace fs = std::filesystem;

int main(int argc, char **argv)
{
    print_hello_world();

    spdlog::info(fmt::format("Welcome to {} v{}\n", project_name, project_version));

    cxxopts::Options options(project_name.data(), "This is all you need to start with C++ projects.");

    options.add_options("arguments")
        ("h,help", "Print usage")
        ("f,filename", "File name", cxxopts::value<std::string>())
        ("v,verbose", "Verbose output", cxxopts::value<bool>()->default_value("false"));

    auto result = options.parse(argc, argv);

    if (result.count("help"))
    {
        std::cout << options.help() << '\n';
        return 0;
    }

    auto filename = std::string{};
    auto verbose = false;

    if (result.count("filename"))
    {
        filename = result["filename"].as<std::string>();
    }
    else
    {
        return 1;
    }

    verbose = result["verbose"].as<bool>();

    if (verbose)
    {
        fmt::print("Opening file: {}\n", filename);
    }

    std::ifstream ifs(filename);

    if (!ifs.is_open())
    {
        return 1;
    }

    json parsed_data = json::parse(ifs);

    if (verbose)
    {
        const auto name = parsed_data["name"];
        fmt::print("Name: {}\n", name);
    }

    return 0;
}
