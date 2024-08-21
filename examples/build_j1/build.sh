#!/bin/bash

# build julsOS with 4 files

current_folder=$PWD
root_folder=$PWD/../..
scripts_folder=$PWD/../../src/scripts

cd $root_folder
make clean && make &&
cp build/boot.bin $current_folder

cd $current_folder
nasm julso.asm -f bin -i../../src/asm/util -o julso.bin &&
nasm juss.asm -f bin -i../../src/asm/util -o juss.bin &&
nasm game.asm -f bin -i../../src/asm/util -o game.bin &&

$scripts_folder/addfile.sh boot.bin julso.bin julso 5
$scripts_folder/addfile.sh boot.bin game.bin game 6 1
$scripts_folder/addfile.sh boot.bin juss.bin juss 8 2

