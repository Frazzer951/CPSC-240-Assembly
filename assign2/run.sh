#!/bin/bash

#Program: assign2
#Author: Luke Eltiste

#Delete some un-needed files
rm *.o
rm *.out
rm *.lis

echo "Assemble quadratic.asm"
nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm

echo "Compile second_degree.c"
gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11

echo "Link the object files"
gcc -m64 -no-pie -o assign2.out -std=c++17 quadratic.o second_degree.o

echo "Run the program assign2:"
./assign2.out

echo "The script file will terminate"