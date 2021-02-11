#!/bin/bash

#Program: Area of Rectangle
#Author: L. Eltiste

#Delete some un-needed files
rm *.o
rm *.out
rm *.lis

echo "Assemble perimeter.asm"
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm -g -gdwarf

echo "Compile rectangle.cpp"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17 -g

echo "Link the object files"
gcc -m64 -no-pie -o rectangle.out -std=c++17 perimeter.o rectangle.o -g

echo "Run the program Area of Rectangle:"
gdb ./rectangle.out

echo "Delete some un-needed files"
rm *.o
rm *.lis

echo "The script file will terminate"