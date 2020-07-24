#include <iostream>

#include "boost/version.hpp"
#include "linalg.h"
#include "loguru.hpp"

#include "dummy.h"

Dummy::Dummy()
{

}

bool Dummy::useBoost()
{
    std::cout << "Boost version: " << BOOST_LIB_VERSION << std::endl;

    return true;
}

bool Dummy::useLinalg()
{
    linalg::aliases::float3 my_float3 {1, 2, 3};

    return true;
}

bool Dummy::useLoguru()
{
    LOG_F(INFO, "The magic number is %d", 42);

    return true;
}
