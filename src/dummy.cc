#include <iostream>

#include "boost/version.hpp"

#include "dummy.h"

Dummy::Dummy()
{

}

const bool Dummy::doSomething()
{
    std::cout << "Boost version: " << BOOST_LIB_VERSION << std::endl;

    return true;
}
