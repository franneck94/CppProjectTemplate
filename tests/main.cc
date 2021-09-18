#define CATCH_CONFIG_MAIN

#include "catch2/catch.hpp"

#include "my_lib.h"

TEST_CASE("Test my cout function", "TestCout")
{
    cout_hello_world();
}

TEST_CASE("Test my vector function", "TestVector")
{
    linalg::aliases::float3 v = print_linalg_vector();

    REQUIRE(1 == v[0]);
    REQUIRE(2 == v[1]);
    REQUIRE(3 == v[2]);
}

TEST_CASE("Test my boost function", "TestBoost")
{
    bool b = print_boost_version();

    REQUIRE(true == b);
}
