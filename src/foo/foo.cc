#include <iostream>

#include "nlohmann/json.hpp"

#include "foo.h"

int print_hello_world()
{
    std::cout << "Cout: Hello World" << '\n';
    std::cout << NLOHMANN_JSON_VERSION_MAJOR << '\n';

    return 1;
}

unsigned int factorial(unsigned int number)
{
    return number <= 1 ? 1 : factorial(number - 1) * number;
}
