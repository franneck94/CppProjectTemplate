#include <iostream>

#include "my_lib.h"

void print_hello_world()
{
    std::cout << "Cout: Hello World" << '\n';
}

unsigned int factorial(unsigned int number)
{
    return number <= 1 ? 1 : factorial(number - 1) * number;
}
