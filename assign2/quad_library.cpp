//*****************************************************************************************************************************
//Program name: "assign2".  This program will take the 3 parts of a quadradtic equation and return the roots  Copyright (C) 2021 Luke Eltiste *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                     *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
//Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                            *
//*****************************************************************************************************************************
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//Author information
//  Author name: Luke Eltiste
//  Author email: lukeeltiste@csu.fullerton.edu
//
//Program information
//  Program name: assign2
//  Programming languages: One file in C, Two files in C++, and one file in X86
//  Date program began:     2021-Feb-18
//  Date program completed: 2021-Feb-22
//  Date comments upgraded: 2021-Feb-22
//  Files in this program: second_degree.c, quadratic.asm, isfloat.cpp, quad_library.cpp
//  Status: Complete.  No errors found after extensive testing.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
//
//Purpose
//  To demonstatrate how to do floating point arithmetic and how to call external functions from an assembly file
//
//This file
//   File name: quad_library.cpp
//   Language: C++
//   Max page width: 132 columns
//   Assemble: gcc -c -Wall -m64 -no-pie -o quad_library.o quad_library.cpp -std=c++17
//   Link: gcc -m64 -no-pie -o assign2.out -std=c++17 second_degree.o quadratic.o isfloat.o quad_library.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8�x11 paper

#include <stdio.h>

extern "C" void show_no_root();
extern "C" void show_one_root( double root );
extern "C" void show_two_root( double root1, double root2 );

void show_no_root()
{
  printf( "There are no real roots\n" );
}
void show_one_root( double root )
{
  printf( "The root is %1.9lf\n", root );
}
void show_two_root( double root1, double root2 )
{
  printf( "The roots are %1.9lf and %1.9lf.\n", root1, root2 );
}