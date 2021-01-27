#define CATCH_CONFIG_MAIN
#include "catch2/catch.hpp"

#include "my_lib.h"
#include "linalg.h"

TEST_CASE("TestSuite_MyLib1", "Test_ComputeAverage")
{
    std::int32_t valueA = 10;
    std::int32_t valueB = 20;
    std::int32_t expectedResult = 15;
    std::int32_t result1 = compute_average(valueA, valueB);
    std::int32_t result2 = compute_average(valueB, valueA);

    REQUIRE(expectedResult == result1);
    REQUIRE(expectedResult == result2);
}

TEST_CASE("TestSuite_MyLib2", "Test_Prints")
{
    bool expectedResult = true;
    bool coutResult = hello_world();
    bool boostResult = print_boost_version();

    REQUIRE(expectedResult == coutResult);
    REQUIRE(expectedResult == boostResult);
}

TEST_CASE("TestSuite_MyLib3", "Test_Vector")
{
    linalg::aliases::float3 expectedResult { 1, 2, 3 };
    linalg::aliases::float3 result = print_linalg_vector(); 

    for (int i = 0; i < 3; ++i)
    {
        REQUIRE(expectedResult[i] == result[i]);
    }
}
