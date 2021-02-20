#!/bin/bash

#Program: assign2
#Author: Luke Eltiste

#Delete some un-needed files
rm *.o
rm *.out
rm *.lis

echo "Compile second_degree.c"
gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11 -g

echo "Compile quadratic.asm"
nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm -g -gdwarf

echo "Compile isfloat.cpp"
gcc -c -Wall -m64 -no-pie -o isfloat.o isfloat.cpp -std=c++17 -g

echo "Compile quad_library.cpp"
gcc -c -Wall -m64 -no-pie -o quad_library.o quad_library.cpp -std=c++17 -g

echo "Link the object files"
gcc -m64 -no-pie -o assign2.out -std=c++17 second_degree.o quadratic.o isfloat.o quad_library.o -g

echo "Run the program assign2:"
gdb ./assign2.out

echo "Delete some un-needed files"
rm *.o
rm *.lis

echo "The script file will terminate"
