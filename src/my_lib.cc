#include <iostream>
#include <stdio.h>

#include "linalg.h"
#include "boost/version.hpp"

#include "my_lib.h"

/**
 * @brief Couts hello world to the console.
 *
 * @return void
 */
void cout_hello_world()
{
    std::cout << "Cout: Hello World" << std::endl;
}

/**
 * @brief Creates and prints out an instance of the float3 class.
 *
 * @return float3 vector
 */
linalg::aliases::float3 print_linalg_vector()
{
    linalg::aliases::float3 my_float3 { 1, 2, 3 };

    std::cout << "Vec: " << my_float3[0] << ", " << my_float3[1] << ", " << my_float3[2] << std::endl;

    return my_float3;
}

/**
 * @brief Couts the version of the installed boost library.
 *
 * @return bool
 */
bool print_boost_version()
{
    std::cout << "Boost version: " << BOOST_VERSION << std::endl;

    return true;
}
