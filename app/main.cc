#include <iostream>

#include "dummy.h"

/*
 * Simple main program.
 */
int main() 
{
  std::cout << "C++ Project Template" << std::endl;

  Dummy d = Dummy();
  (void)d.useBoost();
  (void)d.useLinalg();

  return 0;
}
