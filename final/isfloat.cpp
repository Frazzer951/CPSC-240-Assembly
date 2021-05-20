// Luke Eltiste
// lukeeltiste@csu.fullerton.edu
// Section 5

#include <cstdlib>
#include <ctype.h>

extern "C" bool isfloat( char[] );

bool isfloat( char w[] )
{
  bool isNum      = true;    // This will turn false if a non-digit is found
  int  oneDecimal = 0;       // Keep track of the number of decimals

  int i = 0;                               // Starting place in the char array
  if( w[0] == '+' || w[0] == '-' ) i++;    // If the user adds a + or - at the begining start at the next position

  while( w[i] != '\0' && isNum )
  {
    if( w[i] == '.' ) { oneDecimal++; }    // If decimal is found increment counter
    else
    {
      isNum = isNum && isdigit( w[i] );    //If the current char is not a number, isNum will be false
    }
    i++;
  }
  return isNum && oneDecimal == 1;    // If isNum is true and oneDecimal is below 2, return True
}