//*****************************************************************************************************************************
//Program name: "Interview". This program will conduct an interview and give you a job offer                                  *
//Copyright (C) 2021 Luke Eltiste                                                                                             *
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
//  Program name: Sum of an Array
//  Programming languages:  One file in C++, and One file in X68 Assembly
//  Date program began:     2021-Arp-16
//  Date program completed: 2021-Arp-25
//  Date comments upgraded: 2021-Arp-25
//  Files in this program:  main.cpp and interview.asm
//  Status: Complete.  No errors found after extensive testing.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
//
//Purpose
// To show how to take Char's as input and use them in the program structure
//
//This file
//   File name: main.cpp
//   Language: C++
//   Max page width: 132 columns
//   Assemble: g++ -c -Wall -m64 -no-pie -o main.o main.cpp -std=c++17
//   Link:     g++ -m64 -no-pie -o interview.out -std=c++17 main.o interview.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper

#include <cstring>
#include <iomanip>
#include <iostream>

extern "C" void assembly();

int main()
{
  long   a[6] = { 4, -2, 9, 12, -1, 6 };
  double b[5] = { 7.2, 6.0, 1.5, -3.6, 7.9 };

  assembly();

  int array_size;
  printf( "Please enter the number of cells this array will have " );
  scanf( "%d", &array_size );
  long * myarray = (long *)malloc( array_size * sizeof( long ) );
  int    k       = 0;
  for( k = 0; k < array_size; k++ )
  {
    printf( "Input an integer " );
    scanf( "%ld", &myarray[k] );
  }

  return 0;
}    //End of main
