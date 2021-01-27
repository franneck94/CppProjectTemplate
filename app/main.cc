#include <iostream>

#include "cxxopts.hpp"
#include "loguru.hpp"

#include "my_lib.h"

int main(int argc, char **argv)
{
    hello_world();
    print_linalg_vector();
    print_boost_version();

    loguru::init(argc, argv);
    LOG_F(INFO, "Hello from main!");

    return 0;
}