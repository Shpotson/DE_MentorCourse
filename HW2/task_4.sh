#!/bin/bash

hello() {
    local name="$1"
    echo "Hello, $name"
}

read -p "Enter your name " name
hello "$name"

sum() {
    local num1="$1"
    local num2="$2"
    echo $((num1 + num2))
}

read -p "Enter first num: " number1
read -p "Enter second num: " number2

echo "Answer $(sum "$number1" "$number2")"
