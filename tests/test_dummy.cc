#include <gtest/gtest.h>

#include "dummy.h"

TEST(DummyTestCase, DummyTest)
{
    Dummy d = Dummy();

    const bool actual = d.useBoost();
    const bool expectedPassed = true;
    //const bool expectedFailure = false;

    ASSERT_EQ(expectedPassed, actual); // Should be passed
    //ASSERT_EQ(expectedFailure, actual); // Should be a failure
}