#include <catch2/catch_test_macros.hpp>

#include "foo.h"

TEST_CASE("factorial1")
{
    REQUIRE(factorial(0) == 1);
    REQUIRE(factorial(1) == 1);
    REQUIRE(factorial(2) == 2);
    REQUIRE(factorial(3) == 6);
    REQUIRE(factorial(10) == 3628800);
}

TEST_CASE("helloworld1")
{
    REQUIRE(print_hello_world() == 1);
}
