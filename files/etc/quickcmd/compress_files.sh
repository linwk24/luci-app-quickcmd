#!/bin/sh
cd /mnt/sda1/fns
for file in *; do
    [ -f "$file" ] && tar -a -cf "${file%.*}.zip" "$file" && rm -f "$file"
done