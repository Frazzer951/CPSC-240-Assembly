//*****************************************************************************************************************************
//Program name: "Perimiter of a Rectangle".  This program demonstrates how to input and output float data and how to perform  *
//form a few simple operations on floats.  Copyright (C) 2021 Luke Eltiste                                                    *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                     *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
//Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                            *
//*****************************************************************************************************************************


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Luke Eltiste
//  Author email: lukeeltiste@csu.fullerton.edu
//
//Program information
//  Program name: Perimeter of a Rectangle
//  Programming languages: One modules in C++ and one module in X86
//  Date program began:     2021-Jan-28
//  Date program completed: 2021-Feb-09
//  Date comments upgraded: 2021-Feb-09
//  Files in this program: rectangle.cpp, perimiter.asm, run.sh
//  Status: Complete.  No errors found after extensive testing.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu
//
//Purpose
//  Show how to perform arithmetic operations on float data types
//
//This file
//   File name: rectangle.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17
//   Link: gcc -m64 -no-pie -o perimiterOfRectangle.out -std=c++17 perimiter.o rectangle.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>

extern "C" double perimeter();

int main()
{
  double result_code = -999;
  printf( "Welcome to an friendly assembly program by Luke Eltiste.\n" );
  result_code = perimeter();
  printf( "The main function received this number %1.2lf and has decided to keep it.\n", result_code );
  printf( "A 0 will be returned to the operating system.\n" );
  printf( "Have a nice day.\n" );
  return 0;
}    //End of main