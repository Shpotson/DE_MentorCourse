#!/bin/bash

set -m 

sleep 5 & pid1=$!
sleep 10 & pid2=$!
sleep 15 & pid3=$!
echo "New jobs PIDs: $pid1 , $pid2 , $pid3, jobs:"
jobs

fg %3

echo -e "Jobs after fg:"
jobs

bg %2

echo -e "Jobs after bg:"
jobs
