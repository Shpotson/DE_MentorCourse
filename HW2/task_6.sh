#!/bin/bash

if [[ ! -f input.txt ]]; then
    echo "No input.txt file, check error.log"
    ls input.txt 2> error.log
    exit 1
fi
wc -l < input.txt > output.txt
echo "Check output.txt file"
