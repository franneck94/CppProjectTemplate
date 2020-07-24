#include <gtest/gtest.h>

#include "dummy.h"

TEST(DummyTestCase, DummyTest)
{
    Dummy d = Dummy();

    const bool actualBoost = d.useBoost();
    const bool actualLinalg = d.useLinalg();
    const bool actualLoguru = d.useLoguru();
    const bool expectedPassed = true;

    ASSERT_EQ(expectedPassed, actualBoost);  // Should be passed
    ASSERT_EQ(expectedPassed, actualLinalg); // Should be passed
    ASSERT_EQ(expectedPassed, actualLoguru); // Should be passed
}