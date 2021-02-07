#!/bin/bash

#Program: Area of Rectangle
#Author: L. Eltiste

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble perimiter.asm"
nasm -f elf64 -l perimiter.lis -o perimiter.o perimiter.asm

echo "Compile rectangle.cpp"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17

echo "Link the object files"
gcc -m64 -no-pie -o perimiterOfRectangle.out -std=c++17 perimiter.o rectangle.o

echo "Run the program Area of Rectangle:"
./perimiterOfRectangle.out

echo "The script file will terminate"