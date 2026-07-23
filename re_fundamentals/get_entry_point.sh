#!/bin/bash

source ./messages.sh

if [ $# -ne 1 ]; then
    echo "Usage: $0 <elf_file>"
    exit 1
fi

file_name="$1"

if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

if ! readelf -h "$file_name" > /dev/null 2>&1; then
    echo "Error: '$file_name' is not a valid ELF file."
    exit 1
fi

magic_number=$(readelf -h "$file_name" | grep "Magic" | sed 's/Magic:[ ]*//')

class=$(readelf -h "$file_name" | grep "Class:" | sed 's/.*Class:[ ]*//')

byte_order=$(readelf -h "$file_name" | grep "Data:" | sed 's/.*Data:[ ]*//')

entry_point_address=$(readelf -h "$file_name" | grep "Entry point address" | awk '{print $NF}')

display_elf_header_info
