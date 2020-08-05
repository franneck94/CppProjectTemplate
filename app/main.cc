#include <iostream>

#include "ProjectConfig.h"

#include "my_lib.h"

/**
 * @brief Main function of the executable.
 * 
 * @param argc 
 * @param argv 
 * @return int 
 */
int main()
{
    std::cout << "Project Version: " << PROJECT_VERSION_MAJOR << "." << 
                                        PROJECT_VERSION_MINOR << "." << 
                                        PROJECT_VERSION_PATCH << std::endl;
  
    print_hello_world();
    print_linalg_vector();
    print_boost_version();

    return 0;
}