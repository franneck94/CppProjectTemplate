#include <iostream>

#include "boost/version.hpp"
#include "linalg.h"
#include "loguru.hpp"

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
    linalg::aliases::float3 my_float3 {1, 2, 3};

    return true;
}

const bool Dummy::useLoguru(int argc, char* argv[])
{
    loguru::init(argc, argv);
    loguru::add_file("everything.log", loguru::Truncate, loguru::Verbosity_MAX);
    LOG_F(INFO, "The magic number is %d", 42);

    return true;
}
