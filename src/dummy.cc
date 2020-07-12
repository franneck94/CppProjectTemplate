#include <iostream>

#include "boost/version.hpp"
#include "linalg.h"

#include "dummy.h"

Dummy::Dummy()
{

}

const bool Dummy::useBoost()
{
    std::cout << "Boost version: " << BOOST_LIB_VERSION << std::endl;

    return true;
}

const bool Dummy::useLinalg()
{
    linalg::aliases::float3 my_float3 {1,2,3};

    std::cout << "Linalg vector: " << my_float3[0] << std::endl;

    return true;
}
