//*****************************************************************************************************************************
//Program name: "Sum of an Array".  This program demonstrates how to input an unknown amount of floats and sum them all       *
//together.  Copyright (C) 2021 Luke Eltiste                                                                                  *
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
//  Programming languages: One modules in C++, three modules in X86, and one module in C
//  Date program began:     2021-Mar-08
//  Date program completed: 2021-Mar-14
//  Date comments upgraded: 2021-Mar-20
//  Files in this program: control.asm, display.cpp, fill.asm, main.c, script.sh, and sum.asm
//  Status: Complete.  No errors found after extensive testing.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
//
//Purpose
//  Show how to take user input and store it into an array and then do math on those floats
//
//This file
//   File name: display.cpp
//   Language: C++
//   Max page width: 132 columns
//   Assemble: gcc -c -Wall -m64 -no-pie -o display.o display.cpp -std=c++17
//   Link: gcc -m64 -no-pie -o assign3.out -std=c++17 main.o control.o fill.o sum.o display.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper

#include <stdio.h>

extern "C" void display( double array[], long size );

void display( double array[], long size )
{
  for( long i = 0; i < size; ++i )
  {
    printf( "%1.8lf\n", array[i] );
  }
}