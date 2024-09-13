#!/bin/bash

DIR="."

for file in "$DIR"/*.metta; do
  if [[ -f "$file" ]]; then
    echo "Running: $file"
    echo "----------------------------------------" 
    cat $file
    echo "----------------------------------------" 
    metta "$file"
    echo "----------------------------------------" 
    echo "Finished Running: $file"
    echo "----------------------------------------\n" 
    sleep 5
  else
    echo "$file is not a valid file"
  fi

done