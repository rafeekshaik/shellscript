#!/bin/bash

echo "all variables passed: $@"
echo "number of variables passed: $#"
echo "presnt working directory:$PWD"
echo "home directory of the user: $HOME"
echo "which user running the script: $USER"
echo "pid of the current script: $$"

sleep 70 &
echo "pid of the script running in the back ground: $!"

