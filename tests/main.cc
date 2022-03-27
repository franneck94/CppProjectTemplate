#define CATCH_CONFIG_MAIN

#include "catch2/catch.hpp"

#include "my_lib.h"

TEST_CASE("Test my cout function", "TestCout")
{
    cout_hello_world();
}
