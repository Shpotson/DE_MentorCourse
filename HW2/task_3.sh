#!/bin/bash

read -p "Enter number: " number

if [ $number -ge 0 ]
then
    echo "Positive"
else
    echo "Negative"
fi

echo "Counting from 0 to entered number"
if [ $number -ge 0 ]
then
    current=0
    while (( current <= number )); do
        echo $current
        ((current++))
    done
fi
