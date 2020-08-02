#include <gtest/gtest.h>

#include "my_lib.h"

TEST(DummyTestCase, DummyTest)
{
    bool actualHelloWorld = print_hello_world();
    bool actualLinalg = print_linalg_vector();
    bool actualBoost = print_boost_version();

    ASSERT_EQ(true, actualHelloWorld);
    ASSERT_EQ(true, actualLinalg);
    ASSERT_EQ(true, actualBoost);
}

int main(int argc, char **argv) 
{
    ::testing::InitGoogleTest(&argc, argv); 
    
    return RUN_ALL_TESTS();
}