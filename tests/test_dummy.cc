#include <gtest/gtest.h>

#include "dummy.h"

TEST(DummyTestCase, DummyTest)
{
    Dummy d = Dummy();

    bool actualBoost = d.useBoost();
    bool actualLinalg = d.useLinalg();
    bool actualLoguru = d.useLoguru();
    bool expectedPassed = true;

    ASSERT_EQ(expectedPassed, actualBoost);  // Should be passed
    ASSERT_EQ(expectedPassed, actualLinalg); // Should be passed
    ASSERT_EQ(expectedPassed, actualLoguru); // Should be passed
}