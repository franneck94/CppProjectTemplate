#include <iostream>

#include "dummy.h"

/*
 * Simple main program.
 */
int main(int argc, char* argv[]) 
{
  std::cout << "C++ Project Template" << std::endl;

  Dummy d = Dummy();
  (void)d.useBoost();
  (void)d.useLinalg();
  (void)d.useLoguru(argc, argv);

  return 0;
}
