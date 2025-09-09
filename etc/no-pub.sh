#!/bin/bash

# List of files to modify
files=(
    ctf.sh
    kick.sh
    q2coop.sh
    q2dm64.sh
    q2dm.sh
    roguecoop.sh
    roguedm.sh
    xatrixcoop.sh
    xatrixdm.sh
)

# Loop through each file and replace the line
for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        sed -i 's/+set public 1/+set public 0/g' "$file"
        echo "Updated $file"
    else
        echo "File $file not found."
    fi
done
