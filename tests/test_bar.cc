#include <catch2/catch_test_macros.hpp>

#include "bar.h"

TEST_CASE("sum1")
{
    REQUIRE(summing(0, 1) == 1);
    REQUIRE(summing(1, 0) == 1);
}

TEST_CASE("branch1")
{
    REQUIRE(fn_branch(true, false) == 0);
    REQUIRE(fn_branch(true, true) == 0);
    REQUIRE(fn_branch(false, true) == 0);
    REQUIRE(fn_branch(false, false) == 1);
}
