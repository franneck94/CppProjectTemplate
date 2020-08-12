#include "gtest/gtest.h"

#include "my_lib.h"
#include "linalg.h"

TEST(TestSuite_MyLib, Test_ComputeAverage)
{
    std::int32_t valueA = 10;
    std::int32_t valueB = 20;
    std::int32_t expectedResult = 15;
    std::int32_t result1 = compute_average(valueA, valueB);
    std::int32_t result2 = compute_average(valueB, valueA);

    ASSERT_EQ(expectedResult, result1);
    ASSERT_EQ(expectedResult, result2);
}

TEST(TestSuite_MyLib, Test_Prints)
{
    bool expectedResult = true;
    bool printResult = print_hello_world();
    bool coutResult = cout_hello_world();
    bool boostResult = print_boost_version();

    ASSERT_EQ(expectedResult, printResult);
    ASSERT_EQ(expectedResult, coutResult);
    ASSERT_EQ(expectedResult, boostResult);

    ASSERT_TRUE(printResult);
    ASSERT_TRUE(coutResult);
    ASSERT_TRUE(boostResult);
}

TEST(TestSuite_MyLib, Test_Vector)
{
    linalg::aliases::float3 expectedResult { 1, 2, 3 };
    linalg::aliases::float3 result = print_linalg_vector(); 

    for (int i = 0; i < 3; ++i)
    {
        ASSERT_EQ(expectedResult[i], result[i]);
    }
}

int main(int argc, char **argv)
{
    ::testing::InitGoogleTest(&argc, argv);

    return RUN_ALL_TESTS();
}
