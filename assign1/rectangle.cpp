/*
Welcome to an friendly assembly program by Luke Eltiste.
This program will compute the perimeter and the average side length of a rectangle.
Enter the height:   3.75
Enter the width:    7.2
The perimeter is  21.9
The length of the average side is 5.475
I hope you enjoyed your rectangle
The assembly program will send the perimeter to the main function.
The main function received this number 21.9 and has decided to keep it.
A 0 will be returned to the operating system.
Have a nice day.
*/

#include <stdio.h>
#include <stdint.h>

extern "C" double perimeter();

int main()
{
    double result_code = -999;
    printf("%s\n", "Welcome to an friendly assembly program by Luke Eltiste.");
    result_code = perimeter();
    printf("%s%lf%s\n","The main function received this number ",result_code," and has decided to keep it.");
    printf("%s\n", "A 0 will be returned to the operating system.");
    printf("%s\n", "Have a nice day.");
    return 0;
} //End of main