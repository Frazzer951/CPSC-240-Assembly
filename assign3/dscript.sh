#!/bin/bash

#Program: assign3
#Author: Luke Eltiste

#Delete some un-needed files
rm *.o
rm *.out
rm *.lis

echo "Compile main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11 -g

echo "Compile control.asm"
nasm -f elf64 -l control.lis -o control.o control.asm -g -gdwarf

echo "Compile fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm -g -gdwarf

echo "Compile sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm -g -gdwarf

echo "Compile display.cpp"
gcc -c -Wall -m64 -no-pie -o display.o display.cpp -std=c++17 -g

echo "Link the object files"
gcc -m64 -no-pie -o assign3.out -std=c++17 main.o control.o fill.o sum.o display.o -g

echo "Run the program assign3:"
gdb ./assign3.out

echo "Delete some un-needed files"
rm *.o
rm *.lis

echo "The script file will terminate"
