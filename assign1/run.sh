#!/bin/bash

#Program: Area of Rectangle
#Author: L. Eltiste

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble perimeter.asm"
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

echo "Compile rectangle.cpp"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++17

echo "Link the object files"
gcc -m64 -no-pie -o perimeterOfRectangle.out -std=c++17 perimeter.o rectangle.o

echo "Run the program Area of Rectangle:"
./perimeterOfRectangle.out

echo "The script file will terminate"