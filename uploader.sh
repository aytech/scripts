#!/bin/bash

for d in /home/oleg/Downloads/*; do
  if [ -d "$d" ]; then
    for s in "$d/*"; do
      echo $s
    done
  fi
done
