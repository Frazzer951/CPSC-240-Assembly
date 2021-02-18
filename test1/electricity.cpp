// Luke Eltiste
// CPSC240-5 Test 1

#include <stdio.h>

extern "C" double resistance();

int main()
{
  double result_code = -999.0;
  printf( "Welcome to the Electric Resistance Calculator programmed by Luke Eltiste.\n" );
  result_code = resistance();
  printf( "The Electricity module received this number %1.9lf and has decided to keep it.\n", result_code );
  printf( "Have a very nice evening.  Electricity will now return 0 to the operating system.  Bye.\n" );
  return 0;
}    //End of main