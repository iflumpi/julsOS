#!/bin/bash

# add a file to a sector in a file
# usage:
#   addfile.sh source filename sector [total_files]

if [ $# -lt 3 ]; then
    printf "usage: %s boot source filename sector\n\n" $0
    exit 1
fi

# get parameters
boot_file=$1
source_file=$2
filename=$3
sector=$4
start_byte=$((($sector-1)*512))
if [ $# -gt 4 ]; then
    total_files=$5
else
    total_files=0
fi
file_temp="header_temp.bin"

sector_hex=$(printf "%02x" $sector)

# write header
header_content="\xff\x11"
header_content+=$filename
filename_size="$(echo -n $filename | wc -c)"
loop_i=$((8-filename_size))
for ((i=$loop_i;i>0;i--)); do
    header_content+="\00";
done
header_content+="\x$sector_hex\x00"
header_content+="\x00\x00"

dd if=$boot_file of=$file_temp bs=1 count=$(($total_files*14)) skip=1536 &>/dev/null
echo -e $header_content >>$file_temp
truncate -s -1 $file_temp
header_bytes=$((($total_files+1)*14))
printf "header size: %d\n" $header_bytes
dd if=$file_temp of=$boot_file bs=1 count=$header_bytes seek=1536 conv=notrunc &>/dev/null
dd if=/dev/zero of=$boot_file bs=1 count=$((512-$header_bytes)) seek=$((1536+$header_bytes)) conv=notrunc &>/dev/null
rm $file_temp

source_size=$(cat $source_file | wc -c)
printf "source size: %d\n" $source_size
dd if=$source_file of=$boot_file bs=1 count=$source_size seek=$(($start_byte)) &>/dev/null
dd if=/dev/zero of=$boot_file bs=1 count=$((512-$source_size)) seek=$(($start_byte+$source_size)) &>/dev/null

