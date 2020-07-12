#include <gtest/gtest.h>

int main(int argc, char **argv) 
{
    ::testing::InitGoogleTest(&argc, argv); 

    std::cout << "GTest lib name: " << GTEST_NAME_ << std::endl;
    
    return RUN_ALL_TESTS();
}