#include <iostream>

#include "my_lib.h"

#include "linalg.h"
#include "boost/version.hpp"

bool print_hello_world()
{
    std::cout << "Hello World by CMake from include/my_lib.h" << std::endl;

    return true;
}

bool print_linalg_vector()
{
    linalg::aliases::float3 my_float3 {1, 2, 3};
    std::cout << "Vec: " << my_float3[0] << ", " << my_float3[1] << ", " << my_float3[2] << std::endl;

    return true;
}

bool print_boost_version()
{
    std::cout << "Boost Version: " << BOOST_VERSION << std::endl;

    return true;
}
