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
//  Date program completed: 
//  Date comments upgraded: 
//  Files in this program: second_degree.c, quadratic.asm, isfloat.cpp, quad_library.cpp
//  Status: In Development.
//
//References for this program
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
//
//Purpose
//  To demonstatrate how to do floating point arithmetic and how to call external functions from an assembly file
//
//This file
//   File name: second_degree.c
//   Language: C
//   Max page width: 132 columns
//   Assemble: gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11
//   Link: gcc -m64 -no-pie -o assign2.out -std=c++17 second_degree.o quadratic.o isfloat.o quad_library.o 
//   Optimal print specification: 132 columns width, 7 points, monospace, 8�x11 paper

#include <stdio.h>

double quadratic();

int main()
{
  double result_code = -999;
  printf( "Welcome to Root Calculator\nProgrammed by Luke Eltiste, Professional Programmer.\n" );
  result_code = quadratic();
  printf( "The main driver received %lf and has decided to keep it.\n", result_code );
  printf( "A 0 will be returned to the operating system. Have a nice day. Bye.\n" );
  return 0;
}    //End of main