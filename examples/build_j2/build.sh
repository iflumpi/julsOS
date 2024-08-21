#!/bin/bash

# build julsOS with 1 files

current_folder=$PWD
root_folder=$PWD/../..
scripts_folder=$PWD/../../src/scripts

cd $root_folder/
make &&
cp build/boot.bin $current_folder

cd $current_folder
nasm graphics.asm -f bin -i../../src/asm/util -o graphics.bin &&

$scripts_folder/addfile.sh boot.bin graphics.bin graphics 5

