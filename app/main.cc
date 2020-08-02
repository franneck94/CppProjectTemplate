#include <iostream>

#include "my_lib.h"

/**
 * @brief Main function of the executable.
 * 
 * @param argc 
 * @param argv 
 * @return int 
 */
int main(int argc, char **argv)
{
    print_hello_world();
    print_linalg_vector();
    print_boost_version();

    return 0;
}