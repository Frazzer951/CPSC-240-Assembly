#!/bin/bash

#Program: test1
#Author: Luke Eltiste

#Delete some un-needed files
rm *.o
rm *.out
rm *.lis

echo "Assemble Resistance.asm"
nasm -f elf64 -l perimeter.lis -o resistance.o resistance.asm

echo "Compile Electricity.cpp"
gcc -c -Wall -m64 -no-pie -o electricity.o electricity.cpp -std=c++17

echo "Link the object files"
gcc -m64 -no-pie -o test1.out -std=c++17 Resistance.o electricity.o

echo "Run the program test1:"
./test1.out

echo "The script file will terminate"