#!/bin/bash

#Program: GDB_Tests
#Author: Luke Eltiste

#Delete some un-needed files
rm *.o
rm *.out
rm *.lis

echo "Compile main.cpp"
g++ -c -Wall -m64 -no-pie -o main.o main.cpp -std=c++17

echo "Compile interview.asm"
nasm -f elf64 -l assembly.lis -o assembly.o assembly.asm

echo "Link the object files"
g++ -m64 -no-pie -o GDB_Tests.out -std=c++17 main.o assembly.o

echo "Run the program assign3:"
./GDB_Tests.out

echo "Delete some un-needed files"
rm *.o
rm *.lis

echo "The script file will terminate"
