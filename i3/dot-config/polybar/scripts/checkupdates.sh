#!/bin/sh

number_updates=$(sudo apt update 2>/dev/null | grep upgrade | cut -d " " -f 1)

if [ ! -z "$number_updates" ]; then
  echo $number_updates
else
  echo ""
fi
