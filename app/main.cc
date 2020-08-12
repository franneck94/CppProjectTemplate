#include <iostream>

#include "my_lib.h"
#include "loguru.hpp"

#include "ProjectConfig.h"

int main(int argc, char **argv)
{
    std::cout << PROJECT_VERSION_MAJOR << "."
              << PROJECT_VERSION_MINOR << "."
              << PROJECT_VERSION_PATCH << std::endl;

    cout_hello_world();
    print_linalg_vector();
    print_boost_version();

    loguru::init(argc, argv);
    LOG_F(INFO, "Hello from main!");

    // int i = 128000;
    // short j = i;

    return 0;
}