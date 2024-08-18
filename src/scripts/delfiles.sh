#!/bin/bash

boot_file="boot.bin"
dd if=/dev/zero of=$boot_file bs=1 count=512 seek=1536
