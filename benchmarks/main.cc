#include <random>
#ifndef WIN32
#include <cmath>
#include <cstdlib>
#endif

#include <celero/Celero.h>

#include "dummy.h"

///
/// This is the main(int argc, char** argv) for the entire celero program.
/// You can write your own, or use this macro to insert the standard one into the project.
///
CELERO_MAIN

std::random_device RandomDevice;
std::uniform_int_distribution<int> UniformDistribution(0, 1024);
Dummy d;


BASELINE(DemoSimple, Test1, 10, 1000000)
{
    celero::DoNotOptimizeAway(static_cast<float>(sin(UniformDistribution(RandomDevice))));
}

BENCHMARK(DemoSimple, Test2, 10, 1000000)
{
    celero::DoNotOptimizeAway(d.useLinalg());
}
